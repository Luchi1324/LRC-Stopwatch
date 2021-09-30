//
//  Stopwatch.swift
//  LRC Stopwatch Experimental
//
//  Created by Luciano Mattoli on 23/11/2020.
//

import UIKit

class StopwatchView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Disables stop * reset button initially
        startLapButton.isEnabled = true
        resetButton.isEnabled = false
        stopButton.isEnabled = false
        saveTimeButton.isEnabled = false
        //Creates the toolbar and buttons for interacting with swimmer and event fields
        let doneToolbar = UIToolbar()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(textFieldShouldReturn(_:)))
        let clearBtn = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(textFieldShouldClear(_:)))
        doneToolbar.sizeToFit()
        doneToolbar.setItems([doneBtn, clearBtn], animated: true)
        
        swimmerPicker.delegate = self
        swimmerPicker.dataSource = self
        eventPicker.delegate = self
        eventPicker.dataSource = self
        
        swimmerField.delegate = self
        eventField.delegate = self
        //Sets the inputView (usually keyboard) of each field to their respective pickerView
        swimmerField.inputView = swimmerPicker
        swimmerField.inputAccessoryView = doneToolbar
        eventField.inputView = eventPicker
        eventField.inputAccessoryView = doneToolbar
        fetchSwimmer()
        swimmerPicker.reloadAllComponents()
    }
    func fetchSwimmer() {
        //Fetch from coredata to use in pickerView
        do { self.swimmers = try Context.fetch(Swimmer.fetchRequest())
            DispatchQueue.main.async { self.swimmerPicker.reloadAllComponents() } }
        catch {
            print("Error: Could not fetch swimmers")
        }
    }
    
    //MARK: UI Elements
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lapTable: UITableView!

    @IBOutlet weak var startLapButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var swimmerField: UITextField!
    @IBOutlet weak var eventField: UITextField!
    @IBOutlet weak var saveTimeButton: UIButton!
    
    
    //MARK: Declarations
    var timer = Timer()
    var timerRunning = false
    var (minutes, seconds, milli) = (0, 0, 0)
    var lapTimeArray = [String]()
    var lapNo = 0
    
    let swimmerPicker = UIPickerView()
    let eventPicker = UIPickerView()
    
    var swimmers: [Swimmer]?
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let events = ["50 Free", "100 Free", "200 Free", "400 Free", "800 Free", "1500 Free",
                  "50 Fly", "100 Fly", "200 Fly",
                  "50 Back", "100 Back", "200 Back",
                  "50 Breast", "100 Breast", "200 Breast",
                  "200 IM", "400 IM"]
    let distances = ["50", "100", "150", "200", "250", "300", "350", "400", "450", "500", "550", "600", "650", "700", "750", "800", "850", "900", "950", "1000", "1050", "1100", "1150", "1200", "1250", "1300", "1350", "1400", "1450", "1500"]
    let strokes = ["Fly", "Back", "Breast", "Free"]
    

    //MARK: Start & lap function
    @IBAction func startLapPressed(_ sender: Any) {
        //Checks if timer is running and runs the timer if it isn't, otherwise laps the time if it is running
        //This is done by using a boolean, timerRunning, which is always set to false unless the stopwatch has started
        if !timerRunning {
            //Sets up timer and creates its own thread for it using RunLoop, allowing the timer to work in the background and uninterrupted
            //.scheduledTimer sends out a tick for a set value timeInterval. Here it's every 0.01 seconds since that's the degree of accuracy used in most sports stopwatches
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(StopwatchView.runTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer, forMode: RunLoop.Mode.common)
            //Sets timerRunning to true, so the application knows that the stopwatch is running
            timerRunning = true
            //Enables stop and reset button when timer is running
            startLapButton.isEnabled = true
            resetButton.isEnabled = true
            stopButton.isEnabled = true
            //After starting the timer, disables the lapping button when events 50 free, fly, back, breast is selected
            //This is done since there is only one lap in those events
            if eventField.text == events[0] { startLapButton.isEnabled = false }
            else if eventField.text == events[6] { startLapButton.isEnabled = false }
            else if eventField.text == events[9] { startLapButton.isEnabled = false }
            else if eventField.text == events[12] { startLapButton.isEnabled = false }
        } else {
            //Laps time by adding contents to an array which is synced to a table of lapped times, which is refreshed when content is added so that it's displayed
            //Adaptive lap table: depending on the event selected in the event field, the appended string changes based on event and distance
            //For example, free appends "distance + Free" and breast appends "distance + Breast". If no event is selected, "distance + m" is appended
            switch true {
            case eventField.text == events[0]: //50 Free
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
            case eventField.text == events[1]: //100 Free
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 1 { startLapButton.isEnabled = false }
            case eventField.text == events[2]: //200 Free
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 3 { startLapButton.isEnabled = false }
            case eventField.text == events[3]: //400 Free
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 7 { startLapButton.isEnabled = false }
            case eventField.text == events[4]: //800 Free
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 15 { startLapButton.isEnabled = false }
            case eventField.text == events[5]: //1500 Free
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 29 { startLapButton.isEnabled = false }
            case eventField.text == events[6]: //50 Fly
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[0]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 0 { startLapButton.isEnabled = false }
            case eventField.text == events[7]: //100 Fly
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[0]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 1 { startLapButton.isEnabled = false }
            case eventField.text == events[8]: //200 Fly
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[0]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 3 { startLapButton.isEnabled = false }
            case eventField.text == events[9]: //50 Back
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[1]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 0 { startLapButton.isEnabled = false }
            case eventField.text == events[10]: //100 Back
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[1]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 1 { startLapButton.isEnabled = false }
            case eventField.text == events[11]: //200 Back
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[1]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 3 { startLapButton.isEnabled = false }
            case eventField.text == events[12]: //50 Breast
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[2]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 0 { startLapButton.isEnabled = false }
            case eventField.text == events[13]: //100 Breast
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[2]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 1 { startLapButton.isEnabled = false }
            case eventField.text == events[14]: //200 Breast
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[2]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 3 { startLapButton.isEnabled = false }
            case eventField.text == events[15]: //200 IM
                lapTimeArray.append("\(String(distances[lapNo])) \(strokes[lapNo]): \(timeLabel.text!)")
                lapTable.reloadData()
                lapNo += 1
                    if lapNo == 3 { startLapButton.isEnabled = false }
            case eventField.text == events[16]: //400 IM, each lap has to be recorded individually
                if lapNo == 0 {
                    lapTimeArray.append("\(String(distances[0])) \(strokes[0]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else if lapNo == 1 {
                    lapTimeArray.append("\(String(distances[1])) \(strokes[0]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else if lapNo == 2{
                    lapTimeArray.append("\(String(distances[2])) \(strokes[1]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else if lapNo == 3{
                    lapTimeArray.append("\(String(distances[3])) \(strokes[1]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else if lapNo == 4 {
                    lapTimeArray.append("\(String(distances[4])) \(strokes[2]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else if lapNo == 5 {
                    lapTimeArray.append("\(String(distances[5])) \(strokes[2]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else if lapNo == 6 {
                    startLapButton.isEnabled = false
                    lapTimeArray.append("\(String(distances[6])) \(strokes[3]): \(timeLabel.text!)")
                    lapTable.reloadData()
                    lapNo += 1
                } else {
                    return
                }
            case eventField.text?.isEmpty: //No event selected, then it just records distance and stops at 1500m
                lapTimeArray.append(("\(String(distances[lapNo]))m: \(timeLabel.text!)"))
                lapTable.reloadData()
                lapNo += 1
                if lapNo == 29 { startLapButton.isEnabled = false }
            default:
                return
            lapTable.reloadData()
            }
        }
    }
    //MARK: Reset function
    @IBAction func resetPressed(_ sender: Any) {
        //Stops timerRun() and sets timerRunning to false
        timer.invalidate()
        timerRunning = false
        //Resets labels to 00:00.00
        (minutes, seconds, milli) = (0, 0, 0)
        timeLabel.text = "00:00.00"
        lapNo = 0
        //sets buttons back to starting conditions
        startLapButton.isEnabled = true
        resetButton.isEnabled = false
        stopButton.isEnabled = false
        saveTimeButton.isEnabled = false
        //Resets lap table
        lapTimeArray.removeAll()
        lapTable.reloadData()
    }
    //MARK: stop function
    @IBAction func stopPressed(_ sender: Any) {
        //Stops timerRun()
        timer.invalidate()
        timerRunning = false
        //Gets the swimmer selected and the event selected
        let swimmerToBeUpdated = self.swimmers![self.swimmerPicker.selectedRow(inComponent: 0)]
        let eventSelected = self.eventField.text
        //Converts whatever time is recorded by the stopwatch into seconds, which compares it to the stored second float value
        let currentTime = Float(self.minutes) * 60 + Float(self.seconds) + Float(self.milli) / 100
        //Disables stop button when it is pressed
        stopButton.isEnabled = false
        resetButton.isEnabled = true
        saveTimeButton.isEnabled = true
        //Depending on the event selected in eventField, it compares the current time of the stopwatch to whatever is saved under the swimmer for the same event
        switch true {
        case eventField.text == events[0]: //50 Free
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            //All of the events follow this structure
            //currentTime is compared to what time is recorded for the selected event under the selected swimmer
            if currentTime < swimmerToBeUpdated.fiftyFree {
                //If the time recorded on the stopwatch is less than what is stored, an alert is created that informs the user of this and offers to save it
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                //If the user selects yes, currentTime is saved as the new time for the swimmer's event
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fiftyFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[1]: //100 Free
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.hunFree {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.hunFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[2]: //200 Free
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fiftyFree {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.twoHunFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[3]: //400 Free
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fourHunFree {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fourHunFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[4]: //800 Free
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.eightHunFree {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.eightHunFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[5]: //1500 Free
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[3]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fifteenKFree {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fiftyFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[6]: //50 Fly
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[0]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fiftyFly {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fiftyFly = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[7]: //100 Fly
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[0]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.hunFly {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.hunFly = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[8]: //200 Fly
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[0]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.twoHunFly {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.twoHunFly = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[9]: //50 Back
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[1]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fiftyBack {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fiftyBack = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[10]: //100 Back
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[1]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.hunBack {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.hunBack = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[11]: //200 Back
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[1]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.twoHunBack {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.twoHunBack = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[12]: //50 Breast
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[2]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fiftyBreast {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fiftyBreast = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[13]: //100 Breast
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[2]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.hunBreast {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.hunBreast = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[14]: //200 Breast
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[2]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.twoHunBreast {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.twoHunBreast = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[15]: //200 IM
            lapTimeArray.append("\(String(distances[lapNo])) \(strokes[lapNo]): \(timeLabel.text!)")
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.twoHunIM {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fiftyFree = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text == events[16]: //400 IM
            lapTimeArray.append(("\(String(distances[7])) \(strokes[3]): \(timeLabel.text!)"))
            lapTable.reloadData()
            lapNo += 1
            if currentTime < swimmerToBeUpdated.fourHunIM {
                let alert = UIAlertController(title: "New Best Time!", message: "Do you wish to save \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in swimmerToBeUpdated.fourHunIM = currentTime
                    do { try self.Context.save() }
                    catch { print("Error: Data could not be saved") }
                    self.resetPressed(self)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        case eventField.text?.isEmpty:
            //When no event is selected, the only limit on the lapping function is 1500m
            //the button only disables when it reaches 1500m
            if lapNo < 29 { startLapButton.isEnabled = true } else { startLapButton.isEnabled = false }
            lapTimeArray.append(("\(String(distances[lapNo]))m: \(timeLabel.text!)"))
            lapTable.reloadData()
            lapNo += 1
        default:
            return
        }
    }
    //MARK: Saving a time to a respective swimmer
    @IBAction func saveTimePressed(_ sender: Any) {
        if swimmerField.text?.isEmpty == true {
            //Alert informing the user that no swimmer is selected if the user attempts to save
            let alert = UIAlertController(title: "No Swimmer Selected", message: "Please select a swimmer before saving.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if swimmerField.text?.isEmpty == false && eventField.text?.isEmpty == true {
            //Alert informing the user that no event is selected if the user attempts to save while a swimmer is selected
            let alert = UIAlertController(title: "No Event Selected", message: "Please select a event to save the current time to", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            //Gets the swimmer selected and the event selected
            let swimmerToBeUpdated = self.swimmers![self.swimmerPicker.selectedRow(inComponent: 0)]
            let eventSelected = self.eventField.text
            //Converts whatever time is recorded by the stopwatch into seconds, which compares it to the stored second float value
            let currentTime = Float(self.minutes) * 60 + Float(self.seconds) + Float(self.milli) / 100
            //Alert confirming that the user wants to save the current event time for the chosen swimmer
            let alert = UIAlertController(title: "Save Time?", message: "This will override any existing value for \(swimmerToBeUpdated.name ?? "Swimmer's")'s \(eventSelected ?? "")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            //Checks which event is selected, then saves the current time on the stopwatch to said selected event under the selected swimmer
            switch true {
            case self.eventField.text == self.events[0]:
                //All other cases follow this format
                //Sets the selected swimmer event based on what is chosen, and then sets the time to what currentTime is
                swimmerToBeUpdated.fiftyFree = currentTime
                do {
                    //Saves the swimmer and their updated time
                    try self.Context.save()
                } catch {
                    //Prints an error to the console if the swimmer can't be saved
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[1]:
                swimmerToBeUpdated.hunFree = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[2]:
                swimmerToBeUpdated.twoHunFree = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[3]:
                swimmerToBeUpdated.fourHunFree = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[4]:
                swimmerToBeUpdated.eightHunFree = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[5]:
                swimmerToBeUpdated.fifteenKFree = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[6]:
                swimmerToBeUpdated.fiftyFly = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[7]:
                swimmerToBeUpdated.hunFly = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[8]:
                swimmerToBeUpdated.twoHunFly = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[9]:
                swimmerToBeUpdated.fiftyBack = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[10]:
                swimmerToBeUpdated.hunBack = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[11]:
                swimmerToBeUpdated.twoHunBack = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[12]:
                swimmerToBeUpdated.fiftyBreast = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[13]:
                swimmerToBeUpdated.hunBreast = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[14]:
                swimmerToBeUpdated.twoHunBreast = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[15]:
                swimmerToBeUpdated.twoHunIM = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            case self.eventField.text == self.events[16]:
                swimmerToBeUpdated.fourHunIM = currentTime
                do {
                    try self.Context.save()
                } catch {
                    print("Error: Data could not be saved")
                }
                self.resetPressed(self)
            default:
                return
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        }
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
        //Everytime this function is called, a variable milli is increased by one.
        //Since the function is run every 0.01 seconds, or a millisecond, this is how a stopwatch is created
        milli += 1
        //If 100 milliseconds have passed, a variable second is increased by one to represent a second occuring
        if milli > 99{
            seconds += 1
            milli = 0
        }
        //If 60 seconds have passed, a variable minute is increased by one to represent a minute occuring
        if seconds == 60{
            minutes += 1
            seconds = 0
        }
        //Formats time using a ternairy operator
        //Checks if the above variables are one digit or two digits
        //For example, 9 seconds is shown as 09 and 4 milliseconds is shown as 04
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let milliString = milli > 9 ? "\(milli)" : "0\(milli)"
        //Updates the time label continuously with the above values, creating a stopwatch as these values are updated in realtime
        timeLabel.text = "\(minutesString):\(secondsString).\(milliString)"
    }
}


extension StopwatchView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == swimmerPicker {
            return self.swimmers?.count ?? 0
        } else {
            return events.count
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == swimmerPicker {
            let swimmer = self.swimmers![row]
            return swimmer.name ?? "No swimmers have been created"
      } else {
            let titleRow = events[row]
            return titleRow
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == swimmerPicker {
            //If swimmer is empty, the pickerView is empty
            guard let swimmer = self.swimmers?[row] else { return }
            swimmerField.text = swimmer.name ?? nil
        } else {
            let eventRow = events[row]
            eventField.text = eventRow
        }
    }
}

extension StopwatchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.fetchSwimmer()
        self.swimmerPicker.reloadAllComponents()
        self.view.endEditing(true)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        switch true {
        case swimmerField.isFirstResponder:
            swimmerField.text?.removeAll()
        case eventField.isFirstResponder:
            eventField.text?.removeAll()
        default:
            return true
        }
    return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.fetchSwimmer()
        self.swimmerPicker.reloadAllComponents()
        self.view.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.swimmerPicker.reloadAllComponents()
        self.fetchSwimmer()
    }
}
