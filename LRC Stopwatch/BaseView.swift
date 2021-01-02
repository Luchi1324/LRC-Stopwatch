//
//  ViewController.swift
//  LRC Stopwatch
//
//  Created by Luciano Mattoli on 14/10/2020.

import UIKit

class BaseView: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Sets stopwatch as default view
        self.StopwatchView.isHidden = false
        self.SwimmerView.isHidden = true
    }
    //MARK: Creates different UI containers/multiple menus
    @IBOutlet weak var SwimmerView: UIView!
    @IBOutlet weak var StopwatchView: UIView!
    @IBOutlet weak var SegCtrl: UISegmentedControl!
    
    //MARK: Changes menus using switch and segmented control
    @IBAction func segView(_ sender: UISegmentedControl) {
           switch (sender.selectedSegmentIndex) {
           case 0:
                self.StopwatchView.isHidden = false
                self.SwimmerView.isHidden = true
           case 1:
                self.StopwatchView.isHidden = true
                self.SwimmerView.isHidden = false
           case 2:
                self.StopwatchView.isHidden = true
                self.SwimmerView.isHidden = true
           default:
                self.StopwatchView.isHidden = false
                self.SwimmerView.isHidden = true
           }
           
        }
}
