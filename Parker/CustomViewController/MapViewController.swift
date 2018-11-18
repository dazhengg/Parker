import UIKit
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate{
	
	let newPin = MKPointAnnotation()
	var locationManager = CLLocationManager()
	var locatButtonPressed = false
	
	@IBOutlet weak var map: MKMapView!
	
	override func viewDidLoad() {
			super.viewDidLoad()
			// Do any additional setup after loading the view, typically from a nib.
			self.locationManager.requestWhenInUseAuthorization()
		
			if CLLocationManager.locationServicesEnabled() {
			

			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
        //add transition using swipegesture
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        self.view.addGestureRecognizer(upSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)

					locationManager.delegate = self
					locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
					locationManager.startUpdatingLocation()
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
	
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
			let locValue:CLLocationCoordinate2D = manager.location!.coordinate
			print("locations = \(locValue.latitude) \(locValue.longitude)")
			let userLocation = locations.last! as CLLocation
			let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 600, longitudinalMeters: 600)
			self.map.setRegion(viewRegion, animated: true)
		

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
