//
//  SwimmerDetail.swift
//  LRC Stopwatch Experimental
//
//  Created by Luciano Mattoli on 5/12/2020.
//

import UIKit
import Foundation
import CoreData

class SwimmerDetail: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel?.text = nameDetail
        dobLabel?.text = dobDetail
        genderLabel?.text = genderDetail
        heightLabel?.text = heightDetail + " cm"
        weightLabel?.text = weightDetail + " kilos"
        strokeLabel?.text = strokeDetail
        distanceLabel?.text = distanceDetail
        }

    //MARK: UI Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var strokeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var timeTableView: UITableView!
    
    //MARK: Declarations
    var swimmers: [Swimmer]?
    var indexPath: IndexPath?
    let events = ["50 Free", "100 Free", "200 Free", "400 Free", "800 Free", "1500 Free",
                  "50 Fly", "100 Fly", "200 Fly",
                  "50 Back", "100 Back", "200 Back",
                  "50 Breast", "100 Breast", "200 Breast",
                  "200 IM", "400 IM"]
    
    var times: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var timesString: [String] = ["N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"]
    
    func timesToMMSSMS() {
        //Iterates through an array times[] which is sent from the core data store
        //A for loop is used here because we know that only 16 events need be processed
        //A variable, i, is iterated from 0 to 16 and used to navigate through the times sent
        //I.e. times[i]
        for i in Range(0...16) {
            func secToMMSS(seconds: Float) -> (Float, Float) {
                //Performs calculation that converts float value from storage back into a MM:SS.MS format
                //Takes in one argument, seconds, and returns two float values, minutes and seconds
                //These are the only values that need be calculated, as calculating seconds also gives milliseonds through it's decimal numbers
                return (seconds.truncatingRemainder(dividingBy: 3600) / 60, seconds.truncatingRemainder(dividingBy: 60))
                }
            //Two variables, m and s, are set to returned values of minutes and seconds returned from secToMMSS()
            var (m, s) = secToMMSS(seconds: times[i])
            //Cleans up and makes the numbers more readable,
            //i.e. 0:30.33 not 0.0:30.333003003
            if m < 1 { m = 0 } //If a whole integer minute is not present, it is simply regarded as 0
            if s < 10 {
                //The converted values of minutes and seconds from the seconds in the data store are then converted into a string using string interpolation
                //This is done so it can be displayed easily
                //Seconds are displayed only to two decimal places, the same degree of accuracy for sports stopwatches and how it was inputted
                timesString.insert("\(Int(m)):0\(String(format: "%.2f",s))", at: i)
            } else {
                //Same as above, but doesn't put the 0 in front of the second value if it's greater than 10
                timesString.insert("\(Int(m)):\(String(format: "%.2f",s))", at: i)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            //Transfers data of swimmer selected to swimmerAdd
            guard let VC = segue.destination as? SwimmerAdd else { return }
            //Takes the passed indexPath (selected row) of the swimmer so edited data can be appended to the correct position
            VC.indexPathForSwimmer = self.indexPath
            //Assigns the data of the swimmer to variables used in populating fields in SwimmerAdd
            VC.nameEdit = nameDetail
            VC.dobEdit = dobDetail
            VC.genderEdit = genderDetail
            VC.heightEdit = heightDetail
            VC.weightEdit = weightDetail
            VC.strokeEdit = strokeDetail
            VC.distanceEdit = distanceDetail
            //Visually adds the existing times to the fields, and adds
            VC.fiftyFreeEdit = timesString[0]
            VC.fiftyFreeTime = times[0]
            VC.hunFreeEdit = timesString[1]
            VC.hunFreeTime = times[1]
            VC.twoHunFreeEdit = timesString[2]
            VC.twoHunFreeTime = times[2]
            VC.fourHunFreeEdit = timesString[3]
            VC.fourHunFreeTime = times[3]
            VC.eightHunFreeEdit = timesString[4]
            VC.eightHunFreeTime = times[4]
            VC.fifteenKFreeEdit = timesString[5]
            VC.fifteenKFreeTime = times[5]
            VC.fiftyFlyEdit = timesString[6]
            VC.fiftyFlyTime = times[6]
            VC.hunFlyEdit = timesString[7]
            VC.hunFlyTime = times[7]
            VC.twoHunFlyEdit = timesString[8]
            VC.twoHunFlyTime = times[8]
            VC.fiftyBackEdit = timesString[9]
            VC.fiftyBackTime = times[9]
            VC.hunBackEdit = timesString[10]
            VC.hunBackTime = times[10]
            VC.twoHunBackEdit = timesString[11]
            VC.twoHunBackTime = times[11]
            VC.fiftyBreastEdit = timesString[12]
            VC.fiftyBreastTime = times[12]
            VC.hunBreastEdit = timesString[13]
            VC.hunBreastTime = times[13]
            VC.twoHunBreastEdit = timesString[14]
            VC.twoHunBreastTime = times[14]
            VC.twoHunIMEdit = timesString[15]
            VC.twoHunIMTime = times[15]
            VC.fourHunIMEdit = timesString[16]
            VC.fourHunIMTime = times[16]
            //Changes a boolean to indiciate it is being edited
            VC.isBeingEdited = true
        }
    }
    
    var nameDetail: String = ""
    var genderDetail: String = ""
    var dobDetail: String = ""
    var heightDetail: String = ""
    var weightDetail: String = ""
    var strokeDetail: String = ""
    var distanceDetail: String = ""
    
    
    //MARK: Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Usually would be events.count but 17 is used here because there is always 17 events total
        return 17
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeTableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        //Text to the left is the event and distance i.e. 50 Free
        cell.textLabel?.text = events[indexPath.row]
        //Text to the right is the time for said event i.e. 0:30.00
        cell.detailTextLabel?.text = timesString[indexPath.row]
        return cell
    }
}
