//
//  CountdownTimerViewController.swift
//  crypto_currency_wallet
//
//  Created by lihang pan on 2018/11/15.
//  Copyright © 2018年 lihang pan. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class CountdownTimerViewController: UIViewController{
    @IBOutlet weak var timershowing: UILabel!
   
    @IBOutlet weak var picker: UIPickerView!
    var hour: Int = 0
    var minutes: Int = 0
    
    var seconds: Int = 0
    
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func start(_ sender: UIButton) {
        self.seconds = Int(self.hour) * 3600 + Int(self.minutes) * 60 + Int(self.seconds)
        if isTimerRunning == false {
        runTimer()
        }
    }
    @IBAction func pause(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    
    }
    
    @IBAction func reset(_ sender: UIButton) {
        timer.invalidate()
        self.seconds = 0    //just reset timer to zero
        timershowing.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CountdownTimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
        }else{
            if self.seconds == 901{
                let content = UNMutableNotificationContent()
                content.title = "Parking timer warning"
                content.body = "You only have 15 min left"
                content.sound = UNNotificationSound.default()
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                
            }
        seconds -= 1     //This will decrement(count down)the seconds.
        timershowing.text = timeString(time: TimeInterval(seconds)) //This will update the label.
        }
        
    }
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension CountdownTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return 25
        case 1,2:
            return 60
            
        default:
            return 0
        }
            
        
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) Second"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break;
        }
    }
    
    
}

















