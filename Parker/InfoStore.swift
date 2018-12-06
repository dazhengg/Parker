//
//  InfoStore.swift
//  Parker
//
//  Created by David Zheng on 11/24/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

//f3GKkZJ_WH8 instance ID 
import Foundation
import UIKit
import MapKit
import CoreLocation

class InfoStore: UIViewController, UITextFieldDelegate{
    // latitude
    // longitude
    // name
    // number
   
 
//    @IBOutlet weak var act_name: UITextField!
    @IBOutlet weak var act_num: UITextField!
    @IBOutlet weak var park_location: UITextView!
    
    override func viewDidLoad() {

        
        
        let x_num = UserDefaults.standard.object(forKey:"act_number") as? String
        self.act_num.text = x_num
        print(x_num! )
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: Location.latitude ?? 0, longitude: Location.longitude ?? 0)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in
                
                // Place details
                guard let placeMark = placemarks!.first else { return }
                
               
                
                // Street address 123
                if let street_num = placeMark.subThoroughfare {
                    print(street_num)
                    self.park_location.text += street_num + "\n"
                }
                
                // Street David St
                if let street = placeMark.thoroughfare {
                    print(street)
                    self.park_location.text += street + "\n"
                }
                // City San Francsisco
                if let city = placeMark.subAdministrativeArea {
                    print(city)
                    self.park_location.text += city + "\n"
                }
            
                // Zip code 94122
                if let zip = placeMark.postalCode {
                    print(zip)
                    self.park_location.text += zip + "\n"
                }
             
            
        })
    }

    
    @IBAction func numCheck(_ sender: Any) {
        if User.number == "" {
            act_num.text = "You don't have an number set yet."
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let InfoViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.present(InfoViewController, animated: true, completion: nil)
    }

    
    
}
