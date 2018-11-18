//
//  CountdownTimer.swift
//  Parker
//
//  Created by lihang pan on 2018/11/17.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
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
    var totalseconds: Int = 0
    
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vb = storyboard.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
                self.present(vb, animated: false, completion: nil)
            }
    }
    
    @IBAction func start(_ sender: UIButton) {
    
    
        self.totalseconds = 0
        self.totalseconds = Int(self.hour) * 3600 + Int(self.minutes) * 60 + Int(self.seconds)
        if isTimerRunning == false {
            runTimer()
            //timer.invalidate()
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
        self.totalseconds = 0    //just reset timer to zero
        timershowing.text = timeString(time: TimeInterval(totalseconds))
        isTimerRunning = false
    }
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CountdownTimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTimer() {
        if totalseconds < 1 {
            timer.invalidate()
        }else{
            if self.totalseconds == 901{
                let content = UNMutableNotificationContent()
                content.title = "Parking timer warning"
                content.body = "You only have 15 min left"
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
                
            }
            totalseconds -= 1     //This will decrement(count down)the seconds.
            timershowing.text = timeString(time: TimeInterval(totalseconds)) //This will update the label.
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


