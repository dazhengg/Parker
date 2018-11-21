//
//  classes.swift
//  Parker
//
//  Created by Haoran Zhang on 11/19/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation

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
}

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
}

