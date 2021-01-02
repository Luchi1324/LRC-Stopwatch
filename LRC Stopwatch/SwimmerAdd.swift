//
//  SwimmerAdd.swift
//  LRC Stopwatch Experimental
//
//  Created by Luciano Mattoli on 8/12/2020.
//

import UIKit
import CoreData

class SwimmerAdd: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField?.delegate = self
        self.genderField?.delegate = self
        self.dobField?.delegate = self
        self.heightField?.delegate = self
        self.weightField?.delegate = self
        
        self.fiftyFreeField?.delegate = self
        self.hunFreeField?.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        genderField.inputView = pickerView
        setupDatePicker()
        }
    
    //MARK: UI Elements
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var fiftyFreeField: UITextField!
    @IBOutlet weak var hunFreeField: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    

    //MARK: Declarations
    var nameAdd: String = ""
    var genderAdd: String = ""
    var dobAdd: String = ""
    var heightAdd: String = ""
    var weightAdd: String = ""
    
    var fiftyFreeAdd: Float = 0
    var hunFreeAdd: Float = 0
    
    let genders: [String] = ["Male", "Female", "Other"]
    var addPo: Int = 0
    var indexPath: IndexPath? = nil
    var datePicker: UIDatePicker!
    var pickerView = UIPickerView()
    
    //MARK: Takes user unput and sends via string to SwimmerView
    @IBAction func enterSwimmer(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToView", sender: self)
    }
    //MARK: Erases user input and performs unwind segue
    @IBAction func cancelSwimmer(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindFromCancel", sender: self)
    }
    
    //MARK: Date Selector Setup
    func setupDatePicker() {
        self.datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        self.dobField.inputView = datePicker
        let toolBar:UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 0))
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: #selector(self.doneTapped))
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        self.dobField.inputAccessoryView = toolBar
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func doneTapped() {
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
}
//MARK: Picker View Setup
extension SwimmerAdd: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genders[row]
        genderField.resignFirstResponder()
    }
}
