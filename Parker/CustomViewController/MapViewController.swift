import UIKit
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
	
		let newPin = MKPointAnnotation()
		let currentLocationPin = MKPointAnnotation()
		var locationManager = CLLocationManager()
		var locatButtonPressed = false
		var loginMap = 0
	
		@IBOutlet weak var map: MKMapView!
	
		override func viewDidLoad() {
				super.viewDidLoad()
				// Do any additional setup after loading the view, typically from a nib.
			
			self.locationManager.requestWhenInUseAuthorization()
			
			if CLLocationManager.locationServicesEnabled() {
							self.locationManager.delegate = self
							self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
							self.locationManager.startUpdatingLocation()
			}
			
					//add transition using swipegesture
			let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
			upSwipe.direction = .up
			self.view.addGestureRecognizer(upSwipe)
			
			let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
			leftSwipe.direction = .left
					self.view.addGestureRecognizer(leftSwipe)
			
		}
	
	func initCurrentLocation(){
		let userLocation = self.locationManager.location! as CLLocation
		let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 600, longitudinalMeters: 600)
		self.map.setRegion(viewRegion, animated: false)
	}

	
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            switch sender.direction{
                
            case .up:
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vb = storyboard.instantiateViewController(withIdentifier: "takepictureViewController") as! takepictureViewController
                self.present(vb, animated: true, completion: nil)
            case .left:
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vb = storyboard.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
                self.present(vb, animated: false, completion: nil)
            default:
                break
                
            }
        }
    }
    
    


	
		override func didReceiveMemoryWarning() {
				super.didReceiveMemoryWarning()
				// Dispose of any resources that can be recreated.
		}
	
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations
											 locations: [CLLocation]) {
		
			let locValue:CLLocationCoordinate2D = manager.location!.coordinate
			print("locations = \(locValue.latitude) \(locValue.longitude)")
			let userLocation = locations.last! as CLLocation
		//	let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 600, longitudinalMeters: 600)
		//	self.map.setRegion(viewRegion, animated: false)
		
			// Drop a pin at user's Current Location
		
			if(loginMap == 0){
				initCurrentLocation()
				loginMap = 1
			}
		
			currentLocationPin.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
			currentLocationPin.title = "Current location"
			self.map.addAnnotation(currentLocationPin)
			self.map.delegate = self
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation{
			return nil
		}
		
		let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
		annotationView.image = UIImage(named: "round_near_me_black_24dp")
		annotationView.canShowCallout = true
	
		return annotationView
	}

	
	
		@IBAction func locateButton(_ sender: Any) {
				locatButtonPressed = !locatButtonPressed
				if(locatButtonPressed){
						let userLocation = locationManager.location! as CLLocation
						newPin.coordinate = userLocation.coordinate
						map.addAnnotation(newPin)
				}
		}
}
