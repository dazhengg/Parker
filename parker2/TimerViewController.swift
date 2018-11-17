//
//  TimerViewController.swift
//  crypto_currency_wallet
//
//  Created by lihang pan on 2018/11/15.
//  Copyright © 2018年 lihang pan. All rights reserved.
//

import Foundation
import UIKit

class TimerViewController: UIViewController{
    
    @IBOutlet weak var Timerpresent: UILabel!
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
        Timerpresent.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(CountdownTimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTimer() {
        seconds += 1     //This will decrement(count down)the seconds.
        Timerpresent.text = timeString(time: TimeInterval(seconds)) //This will update the label.
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
