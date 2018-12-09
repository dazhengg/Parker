//
//  Timer.swift
//  Parker
//
//  Created by lihang pan on 2018/11/17.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import UIKit


class TimerViewController: UIViewController{
    
    
    @IBOutlet weak var Timepresent: UILabel!
	@IBOutlet weak var StartButton: UIButton!
	@IBOutlet weak var ResetButton: UIButton!
	

	var hour: Int = 0
    var minutes: Int = 0
    
    var seconds: Int = 0
    
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var timerPaused = false

    var calendar = Calendar.current
    lazy var currentDate = calendar.startOfDay(for: Date())
    lazy var endDate = calendar.startOfDay(for: Date()+1)
    
    let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second]
    lazy var commponent:DateComponents = calendar.dateComponents(unit, from: currentDate, to: endDate)
    lazy var secondStr = commponent.second
    lazy var minitStr = commponent.minute
    lazy var hourStr = commponent.hour
    
    // make a clock in vc
    lazy var secondHandView: UIView = {
        let secondHandView = UIView()
        secondHandView.backgroundColor = UIColor.red
        secondHandView.bounds = CGRect(x: 0, y: 0, width: 1, height: 60)
        
        secondHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return secondHandView
    }()
    lazy var minuteHandView: UIView = {
        let minuteHandView = UIView()
        minuteHandView.backgroundColor = UIColor.darkGray
        minuteHandView.bounds = CGRect(x: 0, y: 0, width: 3, height: 60)
        
        minuteHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return minuteHandView
    }()
    lazy var hourHandView: UIView = {
        let hourHandView = UIView()
        hourHandView.backgroundColor = UIColor.darkGray
        hourHandView.bounds = CGRect(x: 0, y: 0, width: 3, height: 45)
        
        hourHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return hourHandView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dialLayer = CALayer()
        dialLayer.frame = CGRect(x: (UIScreen.main.bounds.width-150)/2, y: 100, width: 150, height: 150)
        dialLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        //dialLayer.position = self.view.center
        dialLayer.contents = UIImage(named: "clock")?.cgImage
        
        
        view.layer.addSublayer(dialLayer)
        secondHandView.frame = CGRect(x: (UIScreen.main.bounds.width-1)/2, y: 115, width: 1, height: 60)
        self.view.addSubview(secondHandView)
        minuteHandView.frame = CGRect(x: (UIScreen.main.bounds.width-3)/2, y: 115, width: 3, height: 60)
        self.view.addSubview(minuteHandView)
        hourHandView.frame = CGRect(x: (UIScreen.main.bounds.width-3)/2, y: 130, width: 3, height: 45)
        
        self.view.addSubview(hourHandView)
		
		
		// try to retrieve the time data
		if  clockTime.clockExistingTimer ?? false{
			if clockTime.clockTimerPaused ?? false { // if timer is paused
				seconds = clockTime.clocksecends ?? 0
				secondStr = clockTime.secondStr ?? 0
				minitStr = clockTime.minitStr ?? 0
				hourStr = clockTime.hourStr ?? 0
				isTimerRunning = false
				timerPaused = true
				clockRunning()
				
			} else { // if timer is running
				StartButton.setTitle("Pause", for: .normal)
				let now = Date()
				let timeDiff = now.timeIntervalSince(clockTime.clockTimeSwiped ?? Date())
				seconds = (clockTime.clocksecends ?? 0)  + Int(round(timeDiff))
				secondStr = (clockTime.secondStr ?? 0) + Int(round(timeDiff))
				minitStr = (clockTime.minitStr ?? 0) + (secondStr ?? 0) / 60
				hourStr = (clockTime.hourStr ?? 0) + (minitStr ?? 0) / 60
				secondStr = (secondStr ?? 0) % 60
				minitStr = (minitStr ?? 0) % 60
				hourStr = (hourStr ?? 0) % 60
		
				
				timerPaused = false
				isTimerRunning = false
				clockRunning()
				runTimer()

			}
		}
       
		//add swipe gestures
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        self.view.addGestureRecognizer(rightSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
    }
	
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            switch sender.direction{
                
            case .left:
				dismiss(animated: false)
				//store the time data when siwped
				clockTime.secondStr = secondStr
				clockTime.minitStr = minitStr
				clockTime.hourStr = hourStr
				clockTime.clocksecends = seconds
				clockTime.clockTimerPaused = timerPaused
				clockTime.clockTimeSwiped = Date()
				timer.invalidate()

            default:
                break
            }
        }
    }
    
    
	@IBAction func backToMapVCButton(_ sender: Any) {
		timer.invalidate()
		self.dismiss(animated: false)
	}
	
    
    @objc func clockRunning() {
		
		if (!timerPaused &&  isTimerRunning){// if timer is not paused then calcuate the clock parameters
        	seconds = seconds + 1
			
			secondStr = secondStr! + 1
			if secondStr == 60 {
				secondStr = 0
				minitStr = minitStr! + 1
				if minitStr == 60 {
					minitStr = 0
					hourStr = hourStr! + 1
					if hourStr == 13 {
						hourStr = 1
					}
				}
			}
		}
        Timepresent.text = timeString(time: TimeInterval(seconds)) //This will update the label.
        
        // calculating angular for minute, hour and second
		print("second string = ", secondStr)
        let secondAngle = CGFloat ( Double(secondStr!) * (Double.pi * 2.0 / 60) )
        secondHandView.transform = CGAffineTransform(rotationAngle: secondAngle)
		print("secondAngle = ", secondAngle)
        
        let minuteAngle = CGFloat ( Double(minitStr!) * (Double.pi * 2.0 / 60) )
        minuteHandView.transform = CGAffineTransform(rotationAngle: minuteAngle)
        print("minAngle = ", minuteAngle)
		
        let hourAngle = CGFloat ( Double(hourStr!) * (Double.pi * 2.0 / 12) )
        hourHandView.transform = CGAffineTransform(rotationAngle: hourAngle)
		print("hourAngle = ", hourAngle)
    }
    
    
   
    
    @IBAction func start(_ sender: UIButton) {
		clockTime.clockExistingTimer = true
		// if the timer is not running and not paused
		if isTimerRunning == false && timerPaused == false {
			runTimer()
			isTimerRunning = true
			StartButton.setTitle("Pause", for: .normal)
			
		}else if isTimerRunning { // if the timer is running, so user wants to pause it
			timer.invalidate()
			isTimerRunning = false
			StartButton.setTitle("Start", for: .normal )
			timerPaused = true
		}else{ // if the timer is paused, we resume running
			self.timerPaused = false
			runTimer()
			isTimerRunning = true
			StartButton.setTitle("Pause", for: .normal)
		}
	
    }
    
	
    
    @IBAction func reset(_ sender: UIButton) {
        timer.invalidate()
        self.seconds = 0    //just reset timer to zero
        secondStr = 0
        minitStr = 0
        hourStr = 0
        //Timepresent.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
		clockTime.clockExistingTimer = false
		timerPaused = false
		StartButton.setTitle("Start", for: .normal)
		clockRunning()
		
    }
	
    func runTimer() {
        if isTimerRunning == false {
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.clockRunning), userInfo: nil, repeats: true)
			//RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
			self.timerPaused = false
		
			isTimerRunning = true
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

