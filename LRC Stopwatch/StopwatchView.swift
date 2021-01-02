//
//  Stopwatch.swift
//  LRC Stopwatch Experimental
//
//  Created by Luciano Mattoli on 23/11/2020.
//

import UIKit

class StopwatchView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Disables stop * reset button initially
    override func viewDidLoad() {
        super.viewDidLoad()
        startLapButton.isEnabled = true
        resetButton.isEnabled = false
        stopButton.isEnabled = false
    }
    //MARK: UI Labels
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lapTable: UITableView!
    //MARK: UI Buttons
    @IBOutlet weak var startLapButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    //MARK: Declares variables used
    var timer = Timer()
    var timerRunning = false
    var (minutes, seconds, milli) = (0, 0, 0)
    var lapTimeArray = [String] ()
    
    //MARK: Start & lap function
    @IBAction func startLapPressed(_ sender: Any) {
        //Checks if timer is running and runs the timer if it isn't, otherwise laps the time if it is running
        if !timerRunning {
            //Sets up timer
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(StopwatchView.runTimer), userInfo: nil, repeats: true)
            timerRunning = true
            //Enables stop and reset button when timer is running
            startLapButton.isEnabled = true
            resetButton.isEnabled = true
            stopButton.isEnabled = true
        } else {
            //Laps time by adding contents to an array than printing it on table view
            lapTimeArray.append("Test: " + timeLabel.text!)
            lapTable.reloadData()
        }
    }
    //MARK: Reset function
    @IBAction func resetPressed(_ sender: Any) {
        //Stops timerRun()
        timer.invalidate()
        timerRunning = false
        //Resets labels to 0
        (minutes, seconds, milli) = (0, 0, 0)
        timeLabel.text = "00:00.00"
        //sets buttons back to starting conditions
        startLapButton.isEnabled = true
        resetButton.isEnabled = false
        stopButton.isEnabled = false
        //Resets lap table
        lapTimeArray.removeAll()
        lapTable.reloadData()
    }
    //MARK: stop function
    @IBAction func stopPressed(_ sender: Any) {
        //Stops timerRun()
        timer.invalidate()
        timerRunning = false
        //Laps the time when it is stopped
        lapTimeArray.append("Test: " + timeLabel.text!)
        lapTable.reloadData()
        //Disables stop button when it is pressed
        startLapButton.isEnabled = true
        resetButton.isEnabled = true
        stopButton.isEnabled = false
        
    }
    //MARK: Lap method using tableView
    //Creates table and updates with values of lapTimeArray taken from the timer
   func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"); cell?.textLabel?.text = lapTimeArray[indexPath.row]
        return cell!
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimeArray.count
    }
    
    //MARK: Acculmating timer method
    @objc func runTimer() {
        milli += 1
        if milli > 99{
            seconds += 1
            milli = 0
        }
        if seconds == 60{
            minutes += 1
            seconds = 0
        }
        //Formats time to be 0s instead of s if < 9
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let milliString = milli > 9 ? "\(milli)" : "0\(milli)"
        //Updates label continuously with above values
        timeLabel.text = "\(minutesString):\(secondsString).\(milliString)"
    }
}
