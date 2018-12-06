//
//  classes.swift
//  Parker
//
//  Created by Haoran Zhang on 11/19/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

//import Firebase

// Usage:
// Getting: phoneNumber = Storage.phoneNumberInE164
// Setting: Storage.phoneNumberInE164 = phoneNumber

struct Location {
    static var latitude: Double? {
        get {
            return UserDefaults.standard.double(forKey: "latitude")
        }
        
        set(latitude) {
            UserDefaults.standard.set(latitude, forKey: "latitude")
            print("Saving latitude as \(UserDefaults.standard.synchronize())")
        }
    }
    
    static var longitude: Double? {
        get {
            return UserDefaults.standard.double(forKey: "longitude")
        }
        
        set(longitude) {
            UserDefaults.standard.set(longitude, forKey: "longitude")
            print("Saving longitude as \(UserDefaults.standard.synchronize())")
        }
    }
} // end location 

struct Storage {
    static var level: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "level")
        }
        
        set(latitude) {
            UserDefaults.standard.set(level, forKey: "level")
            print("Saving level as \(UserDefaults.standard.synchronize())")
        }
    }
    
} // end storage

struct User {
     static var userName: String? { // remove user name TBD
        get {
            return UserDefaults.standard.string(forKey: "act_name")
        }

        set (act_name) {
            UserDefaults.standard.set(act_name, forKey: "act_name")
            print("Saving account name as \(UserDefaults.standard.synchronize())")
        }
    }

     static var number: String? {
        get {
            return UserDefaults.standard.string(forKey: "act_number")
        }

        set (act_name) {
            UserDefaults.standard.set(act_name, forKey: "act_number")
            print("Saving number as \(UserDefaults.standard.synchronize())")
        }
    }
}// end of user







//
//struct MessageID {
//    private enum SettingKey: String {
//        case displayName
//    }
//    static var user_id: FIRAuthDataResult  {
//        
//        get {
//            return UserDefaults.standard.string(forKey: SettingKey.displayName.rawValue)
//        }
//        set {
//            let defaults = UserDefaults.standard
//            let key = SettingKey.displayName.rawValue
//
//            if let name = newValue {
//                defaults.set(name, forKey: key)
//            } else {
//                defaults.removeObject(forKey: key)
//            }
//        }
//    }
//}







