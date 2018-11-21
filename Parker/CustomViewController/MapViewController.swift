import UIKit
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
	
		let carLocationPin = CustomPointAnnotation()
		let currentLocationPin = CustomPointAnnotation()
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

			// Drop a pin at user's Current Location
			let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
		
			map.showsUserLocation = true
		
			if(loginMap == 0){
				self.map.setRegion(viewRegion, animated: false)
				loginMap = 1
			}
		

			self.map.delegate = self
 }
	
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

	
	
    @IBAction func locateButton(_ sender: Any) {
        locatButtonPressed = !locatButtonPressed
        if(locatButtonPressed){
            let userLocation = locationManager.location! as CLLocation
            carLocationPin.coordinate = userLocation.coordinate
						carLocationPin.imageName = "round_directions_car_black_24dp"
            map.addAnnotation(carLocationPin)
            Location.latitude = userLocation.coordinate.latitude
            Location.longitude = userLocation.coordinate.longitude
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
            })
            
        }
    }
}


class CustomPointAnnotation: MKPointAnnotation {
	var imageName: String!
}
