//
//  classes.swift
//  Parker
//
//  Created by Haoran Zhang on 11/19/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import CoreLocation
// Usage:
// Getting: latitude = Location.latitude
// Setting: Location.latitude = latitude

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
		
		set(level) {
			UserDefaults.standard.set(level, forKey: "level")
			print("Saving level as \(UserDefaults.standard.synchronize())")
		}
	}
	
} // end storage

struct User {
	static var userName: String? {
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
} // end of user

struct Time {
	
	static var existingTimer: Bool? {
		get {
			return UserDefaults.standard.bool(forKey: "existingTimer")
		}
		
		set (existingTimer) {
			UserDefaults.standard.set(existingTimer, forKey: "existingTimer")
			print("Saving existingTimer as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var totalSeconds: Int? {
		get {
			return UserDefaults.standard.integer(forKey: "totalSeconds")
		}
		
		set (totalSeconds) {
			UserDefaults.standard.set(totalSeconds, forKey: "totalSeconds")
			print("Saving totalSeconds as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var timeSwiped: Date? {
		get {
			return UserDefaults.standard.object(forKey: "timeSwiped") as? Date
		}
		
		set (timeSwiped) {
			UserDefaults.standard.set(timeSwiped, forKey: "timeSwiped")
			print("Saving timeSwiped as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var timerPaused: Bool? {
		get {
			return UserDefaults.standard.bool(forKey: "timerPaused")
		}
		
		set (timerPaused) {
			UserDefaults.standard.set(timerPaused, forKey: "timerPaused")
			print("Saving timerPaused as \(UserDefaults.standard.synchronize())")
		}
	}
}// end of time


struct clockTime {
	
	static var clockExistingTimer: Bool? {
		get {
			return UserDefaults.standard.bool(forKey: "clockExistingTimer")
		}
		
		set (clockExistingTimer) {
			UserDefaults.standard.set(clockExistingTimer, forKey: "clockExistingTimer")
			print("Saving clockExistingTimer as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var clockTimeSwiped: Date? {
		get {
			return UserDefaults.standard.object(forKey: "clockTimeSwiped") as? Date
		}
		
		set (clockTimeSwiped) {
			UserDefaults.standard.set(clockTimeSwiped, forKey: "clockTimeSwiped")
			print("Saving clockTimeSwiped as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var clockTimerPaused: Bool? {
		get {
			return UserDefaults.standard.bool(forKey: "clockTimerPaused")
		}
		
		set (clockTimerPaused) {
			UserDefaults.standard.set(clockTimerPaused, forKey: "clockTimerPaused")
			print("Saving clockTimerPaused as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var secondStr: Int? {
		get {
			return UserDefaults.standard.integer(forKey: "secondStr")
		}
		
		set (secondStr) {
			UserDefaults.standard.set(secondStr, forKey: "secondStr")
			print("Saving secondStr as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var minitStr: Int? {
		get {
			return UserDefaults.standard.integer(forKey: "minitStr")
		}
		
		set (minitStr) {
			UserDefaults.standard.set(minitStr, forKey: "minitStr")
			print("Saving minitStr as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var hourStr: Int? {
		get {
			return UserDefaults.standard.integer(forKey: "hourStr")
		}
		
		set (hourStr) {
			UserDefaults.standard.set(hourStr, forKey: "hourStr")
			print("Saving hourStr as \(UserDefaults.standard.synchronize())")
		}
	}
	
	static var clocksecends: Int? {
		get {
			return UserDefaults.standard.integer(forKey: "clocksecends")
		}
		
		set (clocksecends) {
			UserDefaults.standard.set(clocksecends, forKey: "clocksecends")
			print("Saving clocksecends as \(UserDefaults.standard.synchronize())")
		}
	}
	
} // end of clock time






