//
//  AddStudentViewController.swift
//  Student Scores
//
//  Created by Reco Gunnels on 5/4/18.
//  Copyright © 2018 Reco Gunnels. All rights reserved.
//

import Foundation
import UIKit

class AddStudentViewController:UIViewController,StudentDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var singleScoresTextField: UITextField!
    @IBOutlet weak var scoresArrayTextField: UITextField!
    var grades:[Int] = [Int]()
    var delegate : StudentDelegate?
    
    func onStudentReady(name: String, grades: [Int])
    {
        let student = Student(studentName: name, studentGrades: grades)
        delegate!.studentsList.append(student)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresArrayTextField.allowsEditingTextAttributes = false
    }
    
    @IBAction func addScoreButton(_ sender: Any) {
        if singleScoresTextField.text != "" {
        grades.append(Int(singleScoresTextField.text!)!)
        }
        else {
            return
        }
        scoresArrayTextField.text = String(describing: grades)
    }
    @IBAction func okButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearScoresButton(_ sender: Any) {
        grades.removeAll()
        scoresArrayTextField.text = nil
    }
    
    
}
