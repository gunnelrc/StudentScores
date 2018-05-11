//
//  ViewController.swift
//  Student Scores
//
//  Created by Reco Gunnels on 4/30/18.
//  Copyright © 2018 Reco Gunnels. All rights reserved.
//

import UIKit
import SQLite3

    

class StudentTableViewController: UIViewController, UIPopoverPresentationControllerDelegate, {
    
    func onStudentReady(name: String, grades: [Int]) {
        print()
    }
    
    
    var students:[Student]!

    
    @IBAction func addButton(_ sender: Any) {
       
        self.performSegue(withIdentifier: "addStudentForm", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        var db:sqliteDataController = sqliteDataController()
      
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addStudentForm" {
            let dest = segue.destination
            if let pop = dest.popoverPresentationController {
                pop.delegate = self
            }
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}

