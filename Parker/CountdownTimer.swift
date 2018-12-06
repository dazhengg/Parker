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
   
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var timershowing: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var totalseconds: Int = 0
    
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var timerPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
   //     self.view.addGestureRecognizer(rightSwipe)
        if Time.existingTimer ?? false{
            if Time.timerPaused ?? false {
                totalseconds = Time.totalSeconds ?? 0
                timershowing.text = timeString(time: TimeInterval(totalseconds))
                timerPaused = true
            } else {
                let now = Date()
                let timeDiff = now.timeIntervalSince(Time.timeSwiped ?? Date())
				print("now in countdown timer is ", now)
				print("time diff in countdown timer is ", timeDiff)
                totalseconds = (Time.totalSeconds ?? 0)  - Int(round(timeDiff))
                if totalseconds > 0 {
                    timershowing.text = timeString(time: TimeInterval(totalseconds))
                    Time.timerPaused = false
                    isTimerRunning = true
                    runTimer()
                }
            }
        }
    }
    
//    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
//        if sender.state == .ended{
//            Time.totalSeconds = totalseconds
//            Time.timeSwiped = Date()
//			dismiss(animated: false)
//         //   let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//          //  let vb = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//          //  self.present(vb, animated: false, completion: nil)
//        }
//    }
	
    @IBAction func start(_ sender: UIButton) {
        Time.existingTimer = true
        Time.timerPaused = false
        if timerPaused {
            runTimer()
            isTimerRunning = true
            timerPaused = false
        } else {
            if isTimerRunning == false {
                totalseconds = hour * 3600 + minutes * 60 + seconds
                runTimer()
            }
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if !timerPaused  && isTimerRunning  {
            timer.invalidate()
            start.isEnabled = true
            timerPaused = true
            Time.timerPaused = true
            //Time.totalSeconds = totalseconds
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        Time.existingTimer = false
        timer.invalidate()
        start.isEnabled = true
        totalseconds = 0    //just reset timer to zero
        timershowing.text = timeString(time: TimeInterval(totalseconds))
        isTimerRunning = false
        timerPaused = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CountdownTimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if totalseconds < 1 {
            timer.invalidate()
            isTimerRunning = false
        }else{
            if totalseconds == 901{
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
	
	override func viewWillDisappear(_ animated: Bool) {
		Time.totalSeconds = totalseconds
		Time.timeSwiped = Date()
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
            return "\(row) "
        case 1:
            return "\(row) "
        case 2:
            return "\(row) "
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


