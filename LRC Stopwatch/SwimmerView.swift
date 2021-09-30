//
//  SwimmerView.swift
//  LRC Stopwatch
//
//  Created by Luciano Mattoli on 3/11/2020.
//

import UIKit
import CoreData

class SwimmerView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swimmerTableView.dataSource = self
        self.swimmerTableView.delegate = self
        fetchSwimmer()
        }
    
    func fetchSwimmer() {
        //Fetch from coredata to display in table view
        do {
            //Sets a variable of a collection of swimmer object equal to the contents of what is stored in core memory
            self.swimmers = try Context.fetch(Swimmer.fetchRequest())
            //DispatchQueue.main.async allows for additional code to be executed whilst data is fetched.
            //Whenever swimmers are fetched, a table displaying the collection of swimmers is refreshed
            //The function is called whenever the view is loaded, ensuring that this table is constant and accurate
            DispatchQueue.main.async { self.swimmerTableView.reloadData() }
        }
        catch {
            print("Error: Could not fetch data")
        }
    }
    //MARK: UI Elements
    @IBOutlet weak var swimmerTableView: UITableView!
    
    //MARK: Declarations
    //Reference to managed object context (Core Data works between this when fetching and creating data)
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var swimmers: [Swimmer]?
    var indexPath: IndexPath = []
    
    //MARK: Passes data to detail view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passDataDetail = segue.destination as? SwimmerDetail {
            //Passes data from selected cell array to detail view
            let swimmerSelected = self.swimmers![indexPath.row]
            //Passes the positon of the selected swimmer, which allows for it to be edited
            passDataDetail.indexPath = self.indexPath
            passDataDetail.nameDetail = swimmerSelected.name!
            passDataDetail.genderDetail = swimmerSelected.gender!
            passDataDetail.dobDetail = swimmerSelected.dob!
            passDataDetail.heightDetail = swimmerSelected.height!
            passDataDetail.weightDetail = swimmerSelected.weight!
            passDataDetail.strokeDetail = swimmerSelected.stroke!
            passDataDetail.distanceDetail = swimmerSelected.distance!
            //Inserts the times selected into a specific position in an array time[]
            //Each position coresponds to an event, i.e. time[0] is 50 free and time[7] is 100 fly
            passDataDetail.times.insert(swimmerSelected.fiftyFree, at: 0)
            passDataDetail.times.insert(swimmerSelected.hunFree, at: 1)
            passDataDetail.times.insert(swimmerSelected.twoHunFree, at: 2)
            passDataDetail.times.insert(swimmerSelected.fourHunFree, at: 3)
            passDataDetail.times.insert(swimmerSelected.eightHunFree, at: 4)
            passDataDetail.times.insert(swimmerSelected.fifteenKFree, at: 5)
            passDataDetail.times.insert(swimmerSelected.fiftyFly, at: 6)
            passDataDetail.times.insert(swimmerSelected.hunFly, at: 7)
            passDataDetail.times.insert(swimmerSelected.twoHunFly, at: 8)
            passDataDetail.times.insert(swimmerSelected.fiftyBack, at: 9)
            passDataDetail.times.insert(swimmerSelected.hunBack, at: 10)
            passDataDetail.times.insert(swimmerSelected.twoHunBack, at: 11)
            passDataDetail.times.insert(swimmerSelected.fiftyBreast, at: 12)
            passDataDetail.times.insert(swimmerSelected.hunBreast, at: 13)
            passDataDetail.times.insert(swimmerSelected.twoHunBreast, at: 14)
            passDataDetail.times.insert(swimmerSelected.twoHunIM, at: 15)
            passDataDetail.times.insert(swimmerSelected.fourHunIM, at: 16)
            //Calls a function to convert seconds back to a MM:SS.MS format after times have been appended, so they can be displayed
            passDataDetail.timesToMMSSMS()
        }
    }
    //MARK: Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.swimmers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = swimmerTableView.dequeueReusableCell(withIdentifier: "swimmerCell", for: indexPath)
        let swimmer = self.swimmers![indexPath.row]
        cell.textLabel?.text = swimmer.name
        cell.detailTextLabel?.text = swimmer.dob
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let swimmerToRemove = self.swimmers![indexPath.row]
            self.Context.delete(swimmerToRemove)
            do {
                try self.Context.save()
            } catch {
                print("Error: Data could not be saved")
            }
            self.fetchSwimmer()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }

    //MARK: Unwind Segue/Appends inputs from SwimmerAdd
    @IBAction func unwindToSwimmerView(_ segue: UIStoryboardSegue) {
        //Determines the source of variables from SwimmerAdd
        if let VC = segue.source as? SwimmerAdd {
        //Creates values based on text inputs from SwimmerAdd, i.e. the text in the name field is declared as name
        let name = VC.nameField.text
        let gender = VC.genderField.text
        let dob = VC.dobField.text
        let height = VC.heightField.text
        let weight = VC.weightField.text
        let stroke = VC.strokeField.text
        let distance = VC.distanceField.text
        //Creates values based on strings containing float values in seconds, converted from the users input
        let fiftyFree = VC.fiftyFreeTime
        let hunFree = VC.hunFreeTime
        let twoHunFree = VC.twoHunFreeTime
        let fourHunFree = VC.fourHunFreeTime
        let eightHunFree = VC.eightHunFreeTime
        let fifteenKFree = VC.fifteenKFreeTime
        let fiftyFly = VC.fiftyFlyTime
        let hunFly = VC.hunFlyTime
        let twoHunFly = VC.twoHunFlyTime
        let fiftyBack = VC.fiftyBackTime
        let hunBack = VC.hunBackTime
        let twoHunBack = VC.twoHunBackTime
        let fiftyBreast = VC.fiftyBreastTime
        let hunBreast = VC.hunBreastTime
        let twoHunBreast = VC.twoHunBreastTime
        let twoHunIM = VC.twoHunIMTime
        let fourHunIM = VC.fourHunIMTime
        //Checks if it is appending data for a swimmer at an existing position or a new one, using a boolean isBeingEdited
        if VC.isBeingEdited == true {
            print("Swimmer is being edited")
            //Updates existing swimmer at indexPath (row position where the swimmer was selected)
            guard let indexPath = VC.indexPathForSwimmer else { return }
            let editedSwimmer = self.swimmers![indexPath.row]
            editedSwimmer.name = name
            editedSwimmer.gender = gender
            editedSwimmer.dob = dob
            editedSwimmer.height = height
            editedSwimmer.weight = weight
            editedSwimmer.stroke = stroke
            editedSwimmer.distance = distance
    
            editedSwimmer.fiftyFree = fiftyFree
            editedSwimmer.hunFree = hunFree
            editedSwimmer.twoHunFree = twoHunFree
            editedSwimmer.fourHunFree = fourHunFree
            editedSwimmer.eightHunFree = eightHunFree
            editedSwimmer.fifteenKFree = fifteenKFree
            editedSwimmer.fiftyFly = fiftyFly
            editedSwimmer.hunFly = hunFly
            editedSwimmer.twoHunFly = twoHunFly
            editedSwimmer.fiftyBack = fiftyBack
            editedSwimmer.hunBack = hunBack
            editedSwimmer.twoHunBack = twoHunBack
            editedSwimmer.fiftyBreast = fiftyBreast
            editedSwimmer.hunBreast = hunBreast
            editedSwimmer.twoHunBreast = twoHunBreast
            editedSwimmer.twoHunIM = twoHunIM
            editedSwimmer.fourHunIM = fourHunIM
            //Saves the data
            do {
                //Calls the save function to append the swimmer object to local storage
                try self.Context.save()
            } catch {
                //If the data cannot be saved, this message is printed for future debugging
                print("Error: Data could not be saved")
            }
            self.fetchSwimmer()
            swimmerTableView.reloadData()
        } else {
            print("Swimmer is being added")
            //Creates a new swimmer object
            let newSwimmer = Swimmer(context: self.Context)
            //Appends data and times for new swimmer
            newSwimmer.name = name
            newSwimmer.gender = gender
            newSwimmer.dob = dob
            newSwimmer.height = height
            newSwimmer.weight = weight
            newSwimmer.stroke = stroke
            newSwimmer.distance = distance
    
            newSwimmer.fiftyFree = fiftyFree
            newSwimmer.hunFree = hunFree
            newSwimmer.twoHunFree = twoHunFree
            newSwimmer.fourHunFree = fourHunFree
            newSwimmer.eightHunFree = eightHunFree
            newSwimmer.fifteenKFree = fifteenKFree
            newSwimmer.fiftyFly = fiftyFly
            newSwimmer.hunFly = hunFly
            newSwimmer.twoHunFly = twoHunFly
            newSwimmer.fiftyBack = fiftyBack
            newSwimmer.hunBack = hunBack
            newSwimmer.twoHunBack = twoHunBack
            newSwimmer.fiftyBreast = fiftyBreast
            newSwimmer.hunBreast = hunBreast
            newSwimmer.twoHunBreast = twoHunBreast
            newSwimmer.twoHunIM = twoHunIM
            newSwimmer.fourHunIM = fourHunIM
            //Saves the data
            do {
                try self.Context.save()
            } catch {
                print("Error: Data could not be saved")
            }
            self.fetchSwimmer()
            swimmerTableView.reloadData()
            }
        VC.isBeingEdited = false
        }
    }
    @IBAction func cancelUnwind(_ segue: UIStoryboardSegue) {
        self.fetchSwimmer()
        swimmerTableView.reloadData()
    }
}

