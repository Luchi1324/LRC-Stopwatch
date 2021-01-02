//
//  SwimmerDetail.swift
//  LRC Stopwatch Experimental
//
//  Created by Luciano Mattoli on 5/12/2020.
//

import UIKit
import CoreData

class SwimmerDetail: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel?.text = nameDetail
        dobLabel?.text = dobDetail
        genderLabel?.text = genderDetail
        heightLabel?.text = heightDetail + " cm"
        weightLabel?.text = weightDetail + " kilos"
        }

    //MARK: UI Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var timeTableView: UITableView!
    
    //MARK: Declarations
    var swimmers: [Swimmer]?
    let events = ["50 Free", "100 Free", "200 Free", "400 Free", "800 Free", "1500 Free",
                  "50 Fly", "100 Fly", "200 Fly",
                  "50 Back", "100 Back", "200 Back",
                  "50 Breast", "100 Breast", "200 Breast",
                  "100 IM", "200 IM", "400 IM"]
    
    var times: [String]? = []
    
    var nameDetail: String = ""
    var genderDetail: String = ""
    var dobDetail: String = ""
    var heightDetail: String = ""
    var weightDetail: String = ""
    
    //MARK: Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return events.count
        return times!.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeTableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row]
        cell.detailTextLabel?.text = times?[indexPath.row] ?? "N/A"
        return cell
    }
}
