//
//  ViewController.swift
//  M4_JCW_Clock
//
//  Created by user247663 on 2/1/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var TimeSetter: UIDatePicker!
    @IBOutlet weak var StartStopLable: UIButton!
    @IBOutlet weak var TimeRemaining: UILabel!
    
    var timer = Timer()
    let formatter = DateFormatter()
    let timeFormatter = DateComponentsFormatter()
    var timeLeft: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func StartStopButton(_ sender: Any) {
        if (!timeLeft.isZero || StartStopLable.currentTitle == "Stop") {
            timeLeft = 0
            StartStopLable.setTitle("Start", for: .normal)
        }
        else {
            StartStopLable.setTitle("Stop", for: .normal)
            timeLeft = TimeSetter.countDownDuration
        }
        
    }
    
    func secondsToHourMinFormat(time: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: time)
    }
    
    @objc func updateTime() {
        
        // dispay current time
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        dateTime.text = formatter.string(from: Date())
        
        // check for am or pm and set colors
        formatter.dateFormat = "a"
        let amPMString = formatter.string(from: Date())
        
        if (amPMString == "PM") {
            view.backgroundColor = UIColor.black
            dateTime.textColor = UIColor.white
            TimeRemaining.textColor = UIColor.white
            TimeSetter.backgroundColor = UIColor.white
        }
        else {
            view.backgroundColor = UIColor.white
            dateTime.textColor = UIColor.black
            TimeRemaining.textColor = UIColor.black
            TimeSetter.backgroundColor = UIColor.black
        }
        
        
        let formTime = secondsToHourMinFormat(time: timeLeft)
        
        TimeRemaining.text = "Time Remaining: \(formTime!)"
        
        if (timeLeft > 0) {
            timeLeft -= 1.0
        }
        else {
            TimeRemaining.text = "Time Remaining:"
        }
    }
}

