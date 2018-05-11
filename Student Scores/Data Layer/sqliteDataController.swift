//
//  sqlliteDataController.swift
//  Student Scores
//
//  Created by Reco Gunnels on 4/30/18.
//  Copyright © 2018 Reco Gunnels. All rights reserved.
//

import Foundation
import SQLite3

class sqliteDataController {
    var db:OpaquePointer?
    
    init() {
        
        }
    public func getNumofStudents() -> Int {
        let count = "SELECT COUNT (id) from Students"
        return Int(count)!
    }
    public func addFakeStudent(){
        var insertNameStatement: OpaquePointer? = nil
        let insertNameStatementString = "INSERT INTO Student (Name) VALUES (?);"
        
        // Insert into Name Table
        if sqlite3_prepare_v2(db, insertNameStatementString, -1, &insertNameStatement, nil) == SQLITE_OK {
            let name: NSString = "Reco Gunnels"
            sqlite3_bind_text(insertNameStatement, 2, name.utf8String, -1, nil)
            if sqlite3_step(insertNameStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertNameStatement)
        // Insert into Grades Table
        var insertGradesStatement: OpaquePointer? = nil
        let insertGradesStatementString = "INSERT INTO Grades (grade) VALUES (?);"
        
        if sqlite3_prepare(db, insertNameStatementString, -1, &insertGradesStatement, nil) == SQLITE_OK {
            let grades:[Int32] = [70,80,90]
            for grade in grades {
                 sqlite3_bind_int(insertGradesStatement, 2, grade)
                if sqlite3_step(insertGradesStatement) == SQLITE_OK {
                     print("Successfully inserted row.")
                }
                else {
                    print("Could not insert row.")
                }
            }
           
        }
    }
    public func DropTables() {
        let dropStudentTableQuery = "DROP TABLE Student;"
        
        if sqlite3_exec(db, dropStudentTableQuery, nil, nil, nil) !=
            SQLITE_OK{
            print("Error deleting student table")
            return
        }
        
        let dropGradesTableQuery = "DROP TABLE GRADES;"
        
        if sqlite3_exec(db, dropGradesTableQuery, nil, nil, nil) !=
            SQLITE_OK{
            print("Error deleting grade table")
            return
        }
        
    }
    public func CreateDatabase() {
        let fileURL = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("StudentDatabase.sqllite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
        let createStudentTableQuery = "IF OBJECT_ID('dbo.Students') IS NULL "
        
        if sqlite3_exec(db, createStudentTableQuery, nil, nil, nil) !=
            SQLITE_OK{
            print("Error creating  student table")
            return
        }
        
        // Create Grades Table
        let createGradesTableQuery = "CREATE TABLE GRADES (ID INTEGER PRIMARY KEY AUTOINCREMENT,StudentID FOREIGN KEY REFERENCES STUDENTS (ID) ,Grade integer)"
        
        if sqlite3_exec(db, createGradesTableQuery, nil, nil, nil) !=
            SQLITE_OK{
            print("Error creating  grades table")
            return
        }
        
    }
        public func AddStudent(name: NSString, grades: [Int]) {
            let insertStatementString = "INSERT INTO Student (Name,Grades) VALUES (?, ?);"
            var insertStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
           
                sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
                
                for grade in grades {
                    print(grade)
                    
                    let insertGradeStatement = "INSERT INTO Student (Grades) Values (" +  String(grade) + ") Where ;"
                    if sqlite3_exec(db, insertGradeStatement, nil, nil, nil) !=
                        SQLITE_OK{
                            print("Error inserting grade")
                    }
                }
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
    
            sqlite3_finalize(insertStatement)

        }
        
    
    
    
    
}
