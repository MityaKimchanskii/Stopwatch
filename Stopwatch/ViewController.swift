//
//  ViewController.swift
//  Stopwatch
//
//  Created by Mitya Kim on 3/28/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let label: UILabel = UILabel(frame: CGRect(x: 100, y: 130, width: 200, height: 150))
    let startStopButton = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 40))
    let resetButton = UIButton(frame: CGRect(x: 100, y: 350, width: 200, height: 40))
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Helper Methods
    @objc func startStopButtonAction(sender: UIButton!) {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        } else {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func resetButtonAction(sender: UIButton!) {
        self.count = 0
        self.timer.invalidate()
        self.label.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
    }
    
    
    func setupViews() {

        startStopButton.backgroundColor = .systemBlue
        startStopButton.setTitle("Start/Stop", for: .normal)
        startStopButton.addTarget(self, action: #selector(startStopButtonAction), for: .touchUpInside)
        self.view.addSubview(startStopButton)
        
        resetButton.backgroundColor = .systemBlue
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
        self.view.addSubview(resetButton)
        
        label.backgroundColor = UIColor.systemCyan
        label.textColor = UIColor.white
        label.font = UIFont(name: "Times New Roman", size: 30)
        label.textAlignment = NSTextAlignment.center
        label.text = "Time"
        self.view.addSubview(label)
        
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        label.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
}

