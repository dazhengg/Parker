import UIKit
import MapKit
import GooglePlaces


class MapViewController: UIViewController ,
UIPickerViewDelegate, UIPickerViewDataSource{
	
	
	
	@IBOutlet weak var navigationImageButton: UIButton!
	let carLocationPin = CustomPointAnnotation()
	let currentLocationPin = CustomPointAnnotation()
	var locationManager = CLLocationManager()
	var locatButtonPressed = false
	var loginMap = 0
	var levelTextField: UITextField?
	let numCols = 1
	var levelArray = [-1,0,1,2,3,4,5,6,7,8]
	var dismissNavigation = false
	//var steps = [MKRoute.Step]()
	//var confirmedLevel = 0
	
	@IBOutlet weak var map: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		//make naviagtion bar transclucent
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = .clear
		self.locationManager.requestWhenInUseAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			self.locationManager.delegate = self
			self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			self.locationManager.startUpdatingLocation()
		}
		
		if let carParkingLatitude = Location.latitude {
			if let carParkingLongtitude = Location.longitude{
				let userLocation = CLLocation(latitude: carParkingLatitude, longitude: carParkingLongtitude)
				carLocationPin.coordinate = userLocation.coordinate
				carLocationPin.imageName = "car_parking_location"
				map.addAnnotation(carLocationPin)
				self.map.delegate = self
			}
		}
		
		//add transition using swipegesture
		let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
		upSwipe.direction = .up
		self.view.addGestureRecognizer(upSwipe)
		
		let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
		leftSwipe.direction = .left
		self.view.addGestureRecognizer(leftSwipe)
		
		let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
		rightSwipe.direction = .right
		self.view.addGestureRecognizer(rightSwipe)
		
	}
	
	
	@objc func handleSwipe(sender: UISwipeGestureRecognizer){
		if sender.state == .ended{
			switch sender.direction{
				
			case .up:
				let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
				let vb = storyboard.instantiateViewController(withIdentifier: "takepictureViewController") as! takepictureViewController
				self.present(vb, animated: true, completion: nil)
				break
			case .right:
				let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
				let vb = storyboard.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
				self.present(vb, animated: false, completion: nil)
				break
			case .left:
			//	let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
			//	let vb = storyboard.instantiateViewController(withIdentifier: "CountdownTimerViewController") as! CountdownTimerViewController
			//	self.present(vb, animated: false, completion: nil)
				let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
				let vc = storyboard.instantiateViewController(withIdentifier: "CountdownTimerViewController") as! CountdownTimerViewController
				if (navigationController != nil) {
					navigationController?.pushViewController(vc, animated: true)
				} else {
					print("Cannot find navigation controller.")
				}
				break
				
				
			default:
				break
				
			}
		}
	}
	
	
	
	
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	
	@IBOutlet weak var distanceLeftLabel: UILabel!
	@IBOutlet weak var timeLeftLabel: UILabel!
	
	func navigationToDestination(reRegion:Bool){
		guard let currentLocationCoordinate = locationManager.location?.coordinate else{
			return
		}
		let sourcePlacemark = MKPlacemark(coordinate: currentLocationCoordinate)
		let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
		
		// getting the destination of navigation
		// which is where user parks the car
		
		guard let latitude = Location.latitude else{
			print("car parking latitude was not recorded")
			return
		}
		guard let longitude = Location.longitude else{
			print("car parking longitude was not recorded")
			return
		}
		let carParkingLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		let carParkPlacemark = MKPlacemark(coordinate: carParkingLocation)
		let carParkMapItem = MKMapItem(placemark: carParkPlacemark)
		
		// ask for navigation request
		let directionsRequst = MKDirections.Request()
		directionsRequst.source = sourceMapItem
		directionsRequst.destination = carParkMapItem
		directionsRequst.transportType = .walking
		
		let directions = MKDirections(request: directionsRequst)
		directions.calculate{response,_ in
			guard let response = response else {return}
			guard let primaryRoute = response.routes.first else {return}
			self.map.removeOverlays(self.map.overlays)
			self.map.addOverlay(primaryRoute.polyline)
			//self.steps = primaryRoute.steps
			self.navigationImageButton.setImage(UIImage(named: "cancel_find_car.png"), for: .normal)
			self.dismissNavigation = true
			let mdf = MKDistanceFormatter()
			let dcf = DateComponentsFormatter()
			mdf.units = .metric
			dcf.unitsStyle = .full
			//dcf.includesTimeRemainingPhrase = true
			dcf.allowedUnits = [.minute]
			self.distanceLeftLabel.text = mdf.string(fromDistance: primaryRoute.distance)
			self.timeLeftLabel.text = dcf.string(from: primaryRoute.expectedTravelTime)
			
			if(reRegion){ // if the navigation button is updated by pressed the find button
				let center = CLLocationCoordinate2DMake((currentLocationCoordinate.latitude + carParkingLocation.latitude) * 0.5, (currentLocationCoordinate.longitude + carParkingLocation.longitude) * 0.5);
				let viewRegion = MKCoordinateRegion(center: center, latitudinalMeters: primaryRoute.distance, longitudinalMeters: primaryRoute.distance)
				self.map.setRegion(viewRegion, animated: true)
				
				
			}
		}
	}
	
	@IBAction func getDirection(_ sender: Any) {
		// getting the start point of navigation,
		// which is current location
		if(!dismissNavigation){
			navigationToDestination(reRegion:true)
			
		}else{
			self.navigationImageButton.setImage(UIImage(named: "find_car.png"), for: .normal)
			self.dismissNavigation = false
			map.removeOverlays(map.overlays)
			self.distanceLeftLabel.text = ""
			self.timeLeftLabel.text = ""
		}
		
	}
	
	@IBAction func nearMeButton(_ sender: Any) {
		guard let currentCoordinate = locationManager.location?.coordinate else {return}
		let viewRegion = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 100, longitudinalMeters: 100)
		self.map.setRegion(viewRegion, animated: true)
	}
	
	@IBAction func locateButton(_ sender: Any) {
		locatButtonPressed = !locatButtonPressed
		if(locatButtonPressed){
			let userLocation = locationManager.location! as CLLocation
			carLocationPin.coordinate = userLocation.coordinate
			carLocationPin.imageName = "car_parking_location"
			map.addAnnotation(carLocationPin)
			Location.latitude = userLocation.coordinate.latitude
			Location.longitude = userLocation.coordinate.longitude
			
			// remove the layout(navigation routine) after press the locate button
			map.removeOverlays(map.overlays)
			/*
			let reverseLocationManager = CLGeocoder()
			reverseLocationManager.reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) -> Void in
			print(userLocation)
			
			
			if error != nil {
			print("Reverse geocoder failed with error" + error!.localizedDescription)
			return
			}
			
			if placemarks != nil {
			guard let locationArray = placemarks else {
			print("Fatal error occured")
			return
			}
			for pm in locationArray {
			print("pm name is \(pm.name ?? "pm name not available")")
			print("pm subLocality name is \(pm.subLocality ?? "subLocality name not available")")
			print("pm subThoroughfare name is \(pm.subThoroughfare ?? "subThoroughfare name not available")")
			//let pm = locationArray[0]
			}
			
			}
			else {
			print("Problem with the data received from geocoder")
			}
			})*/
			
			
			let placesClient = GMSPlacesClient.shared()
			placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
				if let error = error {
					print("Pick Place error: \(error.localizedDescription)")
					return
				}
				
				if let placeLikelihoodList = placeLikelihoodList {
					for likelihood in placeLikelihoodList.likelihoods.prefix(5) {
						let place = likelihood.place
						//if place.name.contains("Sorrento") {
						if place.name.contains("Parking Structure") ||
							place.name.contains("Garage"){
							let alertController = UIAlertController(title: "We detected you are in a parking structure", message: nil, preferredStyle: .alert)
							alertController.addTextField(configurationHandler: self.levelTextFieldConfig)
							let actionConfirm = UIAlertAction(title: "Confirm",style: .default, handler: { (action) in
								Storage.level = Int(self.levelTextField?.text ?? "0")
							})
							let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
							alertController.addAction(actionCancel)
							alertController.addAction(actionConfirm)
							self.present(alertController, animated: true, completion: nil)
							break
						}
					}
				}
			})
		}
	}
	func levelTextFieldConfig(textField : UITextField) {
		levelTextField = textField
		levelTextField?.placeholder = "Please select the level you parked"
		createPicker()
		createToolBar()
	}
	
	func createPicker() {
		let picker = UIPickerView()
		picker.delegate = self
		levelTextField?.inputView = picker
	}
	
	func createToolBar() {
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector (dismissKeyboard))
		let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector (clearInput))
		let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		toolBar.setItems([cancel, space, done], animated: true)
		toolBar.isUserInteractionEnabled = true
		levelTextField?.inputAccessoryView = toolBar
	}
	
	// clear the input and dismiss the keyboard when press 'cancel' on the picker
	@objc func clearInput() {
		levelTextField?.text = ""
		levelTextField?.endEditing(true)
		
	}
	
	// dismiss the keyboard when press 'ok' on the picker
	@objc func dismissKeyboard() {
		levelTextField?.endEditing(true)
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return numCols
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return levelArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(levelArray[row])
	}
	
	// the content that the user finally chooses
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		levelTextField?.text = String(levelArray[row])
		//confirmedLevel = levelArray[row]
	}
	
	
}


extension MapViewController: CLLocationManagerDelegate{
	func locationManager(_ manager: CLLocationManager, didUpdateLocations
		locations: [CLLocation]) {
		
		let locValue:CLLocationCoordinate2D = manager.location!.coordinate
		print("locations = \(locValue.latitude) \(locValue.longitude)")
		let userLocation = locations.last! as CLLocation
		
		// Drop a pin at user's Current Location
		let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
		
		map.showsUserLocation = true
		
		// when user starts to ask for navigation
		// we keep updating time and distance when location changed
		if(dismissNavigation){
			navigationToDestination(reRegion: false)
		}
		
		if(loginMap == 0){
			self.map.setRegion(viewRegion, animated: false)
			loginMap = 1
		}
		
		
		self.map.delegate = self
	}
	
	
}


extension MapViewController: MKMapViewDelegate{
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if !(annotation is CustomPointAnnotation) {
			return nil
		}
		
		let reuseId = "test"
		
		var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
		if anView == nil {
			anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
			anView?.canShowCallout = true
		}
		else {
			anView?.annotation = annotation
		}
		
		//Set annotation-specific properties **AFTER**
		//the view is dequeued or created...
		
		let cpa = annotation as! CustomPointAnnotation
		anView?.image = UIImage(named:cpa.imageName)
		
		return anView
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay is MKPolyline{
			let renderer = MKPolylineRenderer(overlay:overlay)
			renderer.strokeColor = .blue
			renderer.lineWidth = 5
			return renderer
		}
		return MKOverlayRenderer()
	}
	
	
	
}


class CustomPointAnnotation: MKPointAnnotation {
	var imageName: String!
}
