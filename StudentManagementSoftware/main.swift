//
//  main.swift
//  Assignment1
//
//  Created by Shawn Pearce on 2025-05-26.
//

import Foundation

var students: [Student] = []
var threshold: Double=0

class Student {
    let studentID: Int
    let name: String
    var grades:[Double]
    
    init (studentID: Int, name: String, grades: [Double]) {
        self.studentID = studentID
        self.name = name
        self.grades = grades
    }
    
    func averageGrade() -> Double {
        var sum: Double = 0
        for grade in grades{
            sum += grade
            
        }
     let count: Double = Double(grades.count)
        let averageGrade: Double = sum/count
        return averageGrade
    }
    
    func isPassing() -> Bool {
        return averageGrade() >= threshold
    }
    
}

func menuPopup(){
    print("""
        +=-+=-+=- Student Management System -=+-=+-=+
        1. Add a new student
        2. View all students
        3. Calculate average grade for a student
        4. Display passing or failing students
        5. Exit
        """)
}

func addStudent(){
    print("Enter student ID: ")
    
    let studentID = Int(readLine() ?? "") ?? 0
    
    print("Enter student name: ")
    
    let name = readLine() ?? ""
    
    print("Enter grades (separated by space): ")
    
    let gradesString = readLine() ?? ""
    
    let grades: [Double] = gradesString.split(separator: " ").compactMap(Double.init)
    
    let student = Student(studentID: studentID, name: name, grades: grades)
    students.append(student)
    print("Student added successfully!\n")
}

func listStudents(){
    if students.isEmpty {
        print("No students found.\n")
        return
    }
    print("+=-+=- Students -=+-=+")
    for student in students {
        print("\(student.studentID): \(student.name):\(student.grades)")
    }
}
func calcAv(){
    
    print("Enter the student ID to calculate average grade: ")
    
    let input=readLine()
    
    if let studentID=Int(input ?? "Invalid input"){
        
        for student in students{
           
            if student.studentID==studentID{
                print("Average grade: \(student.averageGrade())")
            }
        }
    }
    
}
func passFail(){
    var passingStudents:[Student]=[]
    var failingStudents:[Student]=[]
    print("Enter the threshold to determine passing or failing students: ")
    threshold=Double(readLine() ?? "Invalid input") ?? 0

    for i in students{
        if i.isPassing(){
            passingStudents.append(i)
        }else{
            failingStudents.append(i)
        }
            
            
    }
    print("Passing students")
    for passing in passingStudents{
        print(passing.studentID)
    }
    print("Failing students")
    for failing in failingStudents{
        print(failing.studentID)
    }
    }
while true{
    menuPopup()
    print("Enter your choice:")
    guard let choice = readLine(),let option = Int(choice) else{
        print("Invalid input.  Please enter a number between 1 and 5.\n")
        continue
    }
    
    switch option {
    
    case 1:
        addStudent()
    case 2:
        listStudents()
    case 3:
        calcAv()
    case 4:
        passFail()
    case 5:
        print("Exiting the program. Goodbye!")
        exit(0)
    default:
        print("Invalid choice. Please try again. \n")
        
    }
    
}

