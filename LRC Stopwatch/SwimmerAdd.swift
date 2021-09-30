//
//  SwimmerAdd.swift
//  LRC Stopwatch Experimental
//
//  Created by Luciano Mattoli on 8/12/2020.
//

import UIKit

class SwimmerAdd: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField?.delegate = self
        genderField?.delegate = self
        dobField?.delegate = self
        heightField?.delegate = self
        weightField?.delegate = self
        strokeField?.delegate = self
        distanceField?.delegate = self
        
        fiftyFreeField?.delegate = self
        hunFreeField?.delegate = self
        twoHunFreeField?.delegate = self
        fourHunFreeField?.delegate = self
        eightHunFreeField?.delegate = self
        fifteenKFreeField?.delegate = self
        
        fiftyFlyField?.delegate = self
        hunFlyField?.delegate = self
        twoHunFlyField?.delegate = self
        
        fiftyBackField?.delegate = self
        hunBackField?.delegate = self
        twoHunBackField?.delegate = self
        
        fiftyBreastField?.delegate = self
        hunBreastField?.delegate = self
        twoHunBreastField?.delegate = self
        
        hunIMField?.delegate = self
        twoHunIMField?.delegate = self
        fourHunIMField?.delegate = self
        //Constructs toolbar and done button for gender/time fields and sets the input to their relevant UIPicker()
        let doneToolbar = UIToolbar()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(textFieldShouldReturn(_:)))
        doneToolbar.sizeToFit()
        let deleteBtn = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(textFieldShouldClear(_:)))
        doneToolbar.setItems([doneBtn, deleteBtn], animated: true)
        //Checks if values were passed from an edit segue, and fills the text fields with the data of the swimmer being edited
        if nameEdit != "" {
            nameField.text = nameEdit
            dobField.text = dobEdit
            genderField.text = genderEdit
            heightField.text = heightEdit
            weightField.text = weightEdit
            strokeField.text = strokeEdit
            distanceField.text = distanceEdit
            
            fiftyFreeField.text = fiftyFreeEdit
            hunFreeField.text = hunFreeEdit
            twoHunFreeField.text = twoHunFreeEdit
            fourHunFreeField.text = fourHunFreeEdit
            eightHunFreeField.text = eightHunFreeEdit
            fifteenKFreeField.text = fifteenKFreeEdit
            fiftyFlyField.text = fiftyFlyEdit
            hunFlyField.text = hunFlyEdit
            twoHunFlyField.text = twoHunFlyEdit
            fiftyBackField.text = fiftyBackEdit
            hunBackField.text = hunBackEdit
            twoHunBackField.text = twoHunBackEdit
            twoHunIMField.text = twoHunIMEdit
            fourHunIMField.text = fourHunIMEdit
        }
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderField.inputView = genderPicker
        genderField.inputAccessoryView = doneToolbar
        weightField.inputAccessoryView = doneToolbar
        heightField.inputAccessoryView = doneToolbar
        strokeField.inputView = strokePicker
        strokeField.inputAccessoryView = doneToolbar
        distanceField.inputView = distancePicker
        distanceField.inputAccessoryView = doneToolbar
        createDatePicker()
        
        timePicker.delegate = self
        timePicker.dataSource = self
        strokePicker.delegate = self
        strokePicker.dataSource = self
        distancePicker.delegate = self
        distancePicker.dataSource = self
        //Links the input of time fields to the custom timePicker & toolbar, allows for the user to input the time
        fiftyFreeField.inputView = timePicker
        fiftyFreeField.inputAccessoryView = doneToolbar
        hunFreeField.inputView = timePicker
        hunFreeField.inputAccessoryView = doneToolbar
        twoHunFreeField.inputView = timePicker
        twoHunFreeField.inputAccessoryView = doneToolbar
        fourHunFreeField.inputView = timePicker
        fourHunFreeField.inputAccessoryView = doneToolbar
        eightHunFreeField.inputView = timePicker
        eightHunFreeField.inputAccessoryView = doneToolbar
        fifteenKFreeField.inputView = timePicker
        fifteenKFreeField.inputAccessoryView = doneToolbar
        fiftyFlyField.inputView = timePicker
        fiftyFlyField.inputAccessoryView = doneToolbar
        hunFlyField.inputView = timePicker
        hunFlyField.inputAccessoryView = doneToolbar
        twoHunFlyField.inputView = timePicker
        twoHunFlyField.inputAccessoryView = doneToolbar
        fiftyBackField.inputView = timePicker
        fiftyBackField.inputAccessoryView = doneToolbar
        hunBackField.inputView = timePicker
        hunBackField.inputAccessoryView = doneToolbar
        twoHunBackField.inputView = timePicker
        twoHunBackField.inputAccessoryView = doneToolbar
        fiftyBreastField.inputView = timePicker
        fiftyBreastField.inputAccessoryView = doneToolbar
        hunBreastField.inputView = timePicker
        hunBreastField.inputAccessoryView = doneToolbar
        twoHunBreastField.inputView = timePicker
        twoHunBreastField.inputAccessoryView = doneToolbar
        hunIMField.inputView = timePicker
        hunIMField.inputAccessoryView = doneToolbar
        twoHunIMField.inputView = timePicker
        twoHunIMField.inputAccessoryView = doneToolbar
        fourHunIMField.inputView = timePicker
        fourHunIMField.inputAccessoryView = doneToolbar
        }
    
    //MARK: UI Elements
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var strokeField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    
    @IBOutlet weak var fiftyFreeField: UITextField!
    @IBOutlet weak var hunFreeField: UITextField!
    @IBOutlet weak var twoHunFreeField: UITextField!
    @IBOutlet weak var fourHunFreeField: UITextField!
    @IBOutlet weak var eightHunFreeField: UITextField!
    @IBOutlet weak var fifteenKFreeField: UITextField!
    
    @IBOutlet weak var fiftyFlyField: UITextField!
    @IBOutlet weak var hunFlyField: UITextField!
    @IBOutlet weak var twoHunFlyField: UITextField!
    
    @IBOutlet weak var fiftyBackField: UITextField!
    @IBOutlet weak var hunBackField: UITextField!
    @IBOutlet weak var twoHunBackField: UITextField!
    
    @IBOutlet weak var fiftyBreastField: UITextField!
    @IBOutlet weak var hunBreastField: UITextField!
    @IBOutlet weak var twoHunBreastField: UITextField!
    
    @IBOutlet weak var hunIMField: UITextField!
    @IBOutlet weak var twoHunIMField: UITextField!
    @IBOutlet weak var fourHunIMField: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    

    //MARK: Declarations
    let genders: [String] = ["Male", "Female", "Other"]
    let milli = Array(0 ... 99)
    let seconds = Array(0 ... 59)
    let minutes = Array(0 ... 20)
    
    let strokes = ["Freestyle", "Butterfly", "Backstroke", "Breaststroke"]
    let distances = ["50m", "100m", "200m", "400m", "800m", "1500m"]
    
    let datePicker = UIDatePicker()
    let strokePicker = UIPickerView()
    let distancePicker = UIPickerView()
    let timePicker = UIPickerView()
    let genderPicker = UIPickerView()
    let toolbar = UIToolbar()
    
    var nameEdit: String = ""
    var dobEdit: String = ""
    var genderEdit: String = ""
    var heightEdit: String = ""
    var weightEdit: String = ""
    var strokeEdit: String = ""
    var distanceEdit: String = ""
    var isBeingEdited: Bool = false
    
    var fiftyFreeTime: Float = 0.0
    var fiftyFreeEdit: String = ""
    var hunFreeTime: Float = 0.0
    var hunFreeEdit: String = ""
    var twoHunFreeTime: Float = 0.0
    var twoHunFreeEdit: String = ""
    var fourHunFreeTime: Float = 0.0
    var fourHunFreeEdit: String = ""
    var eightHunFreeTime: Float = 0.0
    var eightHunFreeEdit: String = ""
    var fifteenKFreeTime: Float = 0.0
    var fifteenKFreeEdit: String = ""
    
    var fiftyFlyTime: Float = 0.0
    var fiftyFlyEdit: String = ""
    var hunFlyTime: Float = 0.0
    var hunFlyEdit: String = ""
    var twoHunFlyTime: Float = 0.0
    var twoHunFlyEdit: String = ""
    
    var fiftyBackTime: Float = 0.0
    var fiftyBackEdit: String = ""
    var hunBackTime: Float = 0.0
    var hunBackEdit: String = ""
    var twoHunBackTime: Float = 0.0
    var twoHunBackEdit: String = ""
    
    var fiftyBreastTime: Float = 0.0
    var fiftyBreastEdit: String = ""
    var hunBreastTime: Float = 0.0
    var hunBreastEdit: String = ""
    var twoHunBreastTime: Float = 0.0
    var twoHunBreastEdit: String = ""
    
    var twoHunIMTime: Float = 0.0
    var twoHunIMEdit: String = ""
    var fourHunIMTime: Float = 0.0
    var fourHunIMEdit: String = ""
    
    //var addPo: Int = 0
    var indexPathForSwimmer: IndexPath?
    var swimmer: [Swimmer]?
    
    //MARK: Takes user unput and sends via string to SwimmerView
    @IBAction func enterSwimmer(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToView", sender: self)
    }
    //MARK: Erases user input and performs unwind segue
    @IBAction func cancelSwimmer(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindFromCancel", sender: self)
    }
    
    //MARK: Date Selector Setup
    func createDatePicker() {
        //Sets up toolbar
        let dateToolbar = UIToolbar()
        let dateDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDoneTapped))
        dateToolbar.sizeToFit()
        dateToolbar.setItems([dateDoneBtn], animated: true)
        //Configures date picker for the field
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dobField.inputView = datePicker
        dobField.inputAccessoryView = dateToolbar
    }

    @objc func dateDoneTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dobField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        dobField.resignFirstResponder()
    }
}
//MARK: Text Field Setup
extension SwimmerAdd: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //Identifies which field the function is being called upon, then clears the contents of said field
        switch true {
        case weightField.isFirstResponder:
            weightField.text?.removeAll()
        case heightField.isFirstResponder:
            heightField.text?.removeAll()
        case fiftyFreeField.isFirstResponder:
            fiftyFreeField.text?.removeAll()
        case hunFreeField.isFirstResponder:
            hunFreeField.text?.removeAll()
        case twoHunFreeField.isFirstResponder:
            twoHunFreeField.text?.removeAll()
        case fourHunFreeField.isFirstResponder:
            fourHunFreeField.text?.removeAll()
        case eightHunFreeField.isFirstResponder:
            eightHunFreeField.text?.removeAll()
        case fifteenKFreeField.isFirstResponder:
            fifteenKFreeField.text?.removeAll()
        case fiftyFlyField.isFirstResponder:
            fiftyFlyField.text?.removeAll()
        case hunFlyField.isFirstResponder:
            hunFlyField.text?.removeAll()
        case twoHunFlyField.isFirstResponder:
            twoHunFlyField.text?.removeAll()
        case fiftyBackField.isFirstResponder:
            fiftyBackField.text?.removeAll()
        case hunBackField.isFirstResponder:
            hunBackField.text?.removeAll()
        case twoHunBackField.isFirstResponder:
            twoHunBackField.text?.removeAll()
        case fiftyBreastField.isFirstResponder:
            fiftyBreastField.text?.removeAll()
        case hunBreastField.isFirstResponder:
            hunBreastField.text?.removeAll()
        case twoHunBreastField.isFirstResponder:
            twoHunBreastField.text?.removeAll()
        case twoHunIMField.isFirstResponder:
           twoHunIMField.text?.removeAll()
        case fourHunIMField.isFirstResponder:
            fourHunIMField.text?.removeAll()
        default:
            return true
        }
    return true
    }
}
//MARK: Gender/Time Picker Setup
extension SwimmerAdd: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Identifies which pickerview is open, and changes the number of rows accordingly
        if pickerView == genderPicker {
            return genders.count
        } else if pickerView == strokePicker {
            return strokes.count
        } else if pickerView == distancePicker {
            return distances.count
        } else {
            if component == 0 {
                return minutes.count
            } else if component == 1 {
                return seconds.count
            } else if component == 2 {
                return milli.count
            }
        }
    return 0
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //Identifies which pickerview is open, and changes the number of colmuns accordingly
        if pickerView == genderPicker || pickerView == strokePicker || pickerView == distancePicker {
            return 1
        } else {
            return 3
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Identifies which pickerview is open, and changes the titles in the rows accordingly
        if pickerView == genderPicker {
            let titleRow = genders[row]
            return titleRow
        } else if pickerView == strokePicker {
            let titleRow = strokes[row]
            return titleRow
        } else if pickerView == distancePicker {
            let titleRow = distances[row]
            return titleRow
        } else {
            if component == 0 {
                let minuteRow = minutes[row]
                return String(minuteRow)
            } else if component == 1 {
                let secondRow = seconds[row]
                return String(secondRow)
            } else if component == 2 {
                let milliRow = milli[row]
                return String(milliRow)
            }
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
            genderField.text = genders[row]
        } else if pickerView == strokePicker {
            strokeField.text = strokes[row]
        } else if pickerView == distancePicker {
            distanceField.text = distances[row]
        } else {
            switch true {
            //Determines which textfield is selected, then updates text and swimmer time for the respective field
            case fiftyFreeField.isFirstResponder: //All cases use the same layout
                //Sets values of minutes, seconds and milliseconds based on row selection
                //For example, selecting 23 in the second row inputs 23 seconds into the application
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                //Formats so seconds and milliseconds less than 10 is read as 0s, not s. For example,
                //This is done so it looks like a standard swimming time.
                if sRow < 10 { fiftyFreeField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fiftyFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { fiftyFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fiftyFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                //Converts input of MM:SS.MS into seconds
                //This allows for times to be compared, so if a faster time is achieved it can be saved over.
                fiftyFreeTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case hunFreeField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { hunFreeField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { hunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { hunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { hunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                hunFreeTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case twoHunFreeField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { twoHunFreeField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { twoHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { twoHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { twoHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                twoHunFreeTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case fourHunFreeField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { fourHunFreeField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fourHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { fourHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fourHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                fourHunFreeTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case eightHunFreeField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { eightHunFreeField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { eightHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { eightHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { eightHunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                eightHunFreeTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case fifteenKFreeField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { fifteenKFreeField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fifteenKFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { fifteenKFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fifteenKFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                fifteenKFreeTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case fiftyFlyField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { fiftyFlyField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fiftyFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { hunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fiftyFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                fiftyFlyTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case hunFlyField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { hunFlyField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { hunFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { hunFreeField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { hunFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                hunFlyTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case twoHunFlyField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { twoHunFlyField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { twoHunFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { twoHunFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { twoHunFlyField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                twoHunFlyTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case fiftyBackField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { fiftyBackField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fiftyBackField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { fiftyBackField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fiftyBackField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                fiftyBackTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case hunBackField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { hunBackField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { hunBackField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { hunBackField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { hunBackField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                hunBackTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case twoHunBackField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { twoHunBackField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { twoHunBackField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { twoHunBackField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { twoHunBackField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                twoHunBackTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case fiftyBreastField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { fiftyBreastField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fiftyBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { fiftyBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fiftyBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                fiftyBreastTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case hunBreastField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { hunBreastField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { hunBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { hunBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { hunBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                hunBreastTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case twoHunBreastField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { twoHunBreastField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { twoHunBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { twoHunBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { twoHunBreastField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                twoHunBreastTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case twoHunIMField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { twoHunIMField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { twoHunIMField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { twoHunIMField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { twoHunIMField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                twoHunIMTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            case fourHunIMField.isFirstResponder:
                let mRow = pickerView.selectedRow(inComponent: 0)
                let sRow = pickerView.selectedRow(inComponent: 1)
                let miRow = pickerView.selectedRow(inComponent: 2)
                if sRow < 10 { fourHunIMField.text = "\(minutes[mRow]):0\(seconds[sRow]).\(milli[miRow])" }
                else { fourHunIMField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                if miRow < 10 { fourHunIMField.text = "\(minutes[mRow]):\(seconds[sRow]).0\(milli[miRow])" }
                else { fourHunIMField.text = "\(minutes[mRow]):\(seconds[sRow]).\(milli[miRow])" }
                fourHunIMTime = Float(minutes[mRow]) * 60 + Float(seconds[sRow]) + Float(milli[miRow]) / 100
            default:
                return
            }
        }
    }
}
