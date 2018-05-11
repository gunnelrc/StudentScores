//
//  Student.swift
//  Student Scores
//
//  Created by Reco Gunnels on 4/30/18.
//  Copyright © 2018 Reco Gunnels. All rights reserved.
//

import Foundation
import SQLite3
// Create for each Student in the database
public struct Student {
    struct Name {
        var name: String!
    }
    struct Grades{
        var grades = [Int]()
    }
    init (studentName:String, studentGrades:[Int]) {
        Name.init(name: studentName)
        Grades.init(grades: studentGrades)
        
    }
    
}
public protocol StudentDelegate {
    var studentsList:[Student] { get set }
    func onStudentReady(name: String, grades: [Int] )
}
