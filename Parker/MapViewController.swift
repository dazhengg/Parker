import UIKit
import MapKit

class MapViewController: UIViewController , CLLocationManagerDelegate{
	
	
	var locationManager = CLLocationManager()
	
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
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		let locValue:CLLocationCoordinate2D = manager.location!.coordinate
		print("locations = \(locValue.latitude) \(locValue.longitude)")
		let userLocation = locations.last
		let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
		self.map.setRegion(viewRegion, animated: true)
	}
	
}
