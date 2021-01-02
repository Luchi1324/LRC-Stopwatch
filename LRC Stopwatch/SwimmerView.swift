//
//  SwimmerView.swift
//  LRC Stopwatch
//
//  Created by Luciano Mattoli on 3/11/2020.
//

import UIKit
import CoreData

class SwimmerView: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swimmerTableView.dataSource = self
        self.swimmerTableView.delegate = self
        fetchSwimmer()
        }
    
    func fetchSwimmer() {
        //Fetch from coredata to display in table view
        do {
            self.swimmers = try Context.fetch(Swimmer.fetchRequest())
            DispatchQueue.main.async { self.swimmerTableView.reloadData() }
        }
        catch {}
    }
    //MARK: UI Elements
    @IBOutlet weak var swimmerTableView: UITableView!
    
    //MARK: Declarations
    //reference to managed object context (Core Data works between this when fetching and creating data)
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var swimmers: [Swimmer]?
    var indexNo = 0
    
    //MARK: Passes data to detail view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passDataDetail = segue.destination as? SwimmerDetail {
            //Passes data from selected cell array to detail view
            let swimmerSelected = self.swimmers![indexNo]
            passDataDetail.nameDetail = swimmerSelected.name!
            passDataDetail.genderDetail = swimmerSelected.gender!
            passDataDetail.dobDetail = swimmerSelected.dob!
            passDataDetail.heightDetail = swimmerSelected.height!
            passDataDetail.weightDetail = swimmerSelected.weight!
            
            passDataDetail.times?.append(String(swimmerSelected.fiftyFree))
            passDataDetail.times?.append(String(swimmerSelected.hunFree))
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
            try! self.Context.save()
            self.fetchSwimmer()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNo = indexPath.row
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }

    //MARK: Unwind Segue/Appends inputs from SwimmerAdd
    @IBAction func unwindToSwimmerView(_ segue: UIStoryboardSegue) {
        //Determines the source of variables from SwimmerAdd
        guard let VC = segue.source as? SwimmerAdd else { return }
        //Creates values based on text inputs from SwimmerAdd
        guard let name = VC.nameField.text else { return }
        guard let gender = VC.genderField.text else { return }
        guard let dob = VC.dobField.text else { return }
        guard let height = VC.heightField.text else { return }
        guard let weight = VC.weightField.text else { return }
        
        guard let fiftyFree = VC.fiftyFreeField.text else { return }
        guard let hunFree = VC.hunFreeField.text else { return }
        //Creates a swimmer object from above values, adds times object
        let newSwimmer = Swimmer(context: self.Context)
        newSwimmer.name = name
        newSwimmer.gender = gender
        newSwimmer.dob = dob
        newSwimmer.height = height
        newSwimmer.weight = weight
        
        newSwimmer.fiftyFree = Float(fiftyFree)!
        newSwimmer.hunFree = Float(hunFree)!
        //Saves the data
        try! self.Context.save()
        self.fetchSwimmer()
        swimmerTableView.reloadData()
    }
    @IBAction func cancelUnwind(_ segue: UIStoryboardSegue) {
        swimmerTableView.reloadData()
    }
}
