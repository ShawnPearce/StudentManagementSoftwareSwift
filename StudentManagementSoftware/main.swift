////  main.swift
//  Student Management System
//  1 file
//  A console application for managing student records,
//  calculating averages, and determining pass/fail status
//
//  Created by Shawn Pearce.
//  Student ID: 991819655
//  GitHub: https://github.com/ShawnPearce/MobileComputingA1

import Foundation

// Constants for grade validation
let MIN_GRADE: Double = 0.0
let MAX_GRADE: Double = 100.0

// Global variables to store student data and passing threshold
var students: [Student] = []
var threshold: Double = 0

// Student class to represent individual student records
class Student {
    // Student properties
    let studentID: Int
    let name: String
    var grades: [Double]
    
    // Initialize a new student with ID, name, and grades
    init(studentID: Int, name: String, grades: [Double]) {
        self.studentID = studentID
        self.name = name
        self.grades = grades
    }
    
    //Calculates the average grade for this student
    //Returns 0.0 if no grades are present
    
    func averageGrade() -> Double {
        if grades.count == 0 {
            return 0.0
        }
        
        var sum: Double = 0
        for grade in grades {
            sum += grade
        }
        let count: Double = Double(grades.count)
        let averageGrade: Double = sum/count
        return averageGrade
    }
    
    //Determines if the student is passing
    func isPassing() -> Bool {
        return averageGrade() >= threshold
    }
}

//Display menu options
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

//Prompt to add new student to the system
func addStudent(){
    var studentID: Int = 0
    var validID = false
    
    // Loop until valid student ID is entered
    while validID == false {
        print("Enter student ID: ")
        let input = readLine() ?? ""
        
        // Check for empty input
        if input == "" {
            print("Error: Please enter a student ID number.")
        }
        // Validate numeric input and positive value
        else if let id = Int(input) {
            if id > 0 {
                studentID = id
                validID = true
            } else {
                print("Error: Student ID must be greater than 0.")
            }
        } else {
            print("Error: Please enter a valid number.")
        }
    }
    
    var name: String = ""
    var validName = false
    
    // Loop until valid name is entered
    while validName == false {
        print("Enter student name: ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Name cannot be empty.")
        } else {
            name = input
            validName = true
        }
    }
    
    var grades: [Double] = []
    var validGrades = false
    
    // Loop until valid grades are entered
    while validGrades == false {
        print("Enter grades separated by spaces (example: 85.5 90 78): ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter at least one grade.")
        } else {
            let gradeStrings = input.split(separator: " ")
            var tempGrades: [Double] = []
            var hasError = false
            
            // Validate each grade individually
            for gradeString in gradeStrings {
                let gradeText = String(gradeString)
                
                if let grade = Double(gradeText) {
                    if grade >= MIN_GRADE && grade <= MAX_GRADE {
                        tempGrades.append(grade)
                    } else {
                        print("Error: Grade '\(gradeText)' must be between \(MIN_GRADE) and \(MAX_GRADE).")
                        hasError = true
                        break
                    }
                } else {
                    print("Error: '\(gradeText)' is not a valid number.")
                    hasError = true
                    break
                }
            }
            
            // Only accept grades if all are valid
            if hasError == false {
                grades = tempGrades
                validGrades = true
                print("Successfully added \(grades.count) grades.")
            }
        }
    }
    
    // Create and add the new student
    let student = Student(studentID: studentID, name: name, grades: grades)
    students.append(student)
    print("Student added successfully!\n")
}

//Display a list of students, student ID and Grades
func listStudents(){
    if students.count == 0 {
        print("No students found.\n")
        return
    }
    print("+=-+=- Students -=+-=+")
    for student in students {
        print("\(student.studentID): \(student.name): \(student.grades)")
    }
    print()
}

//Calculate average grades for a specific student and handle errors
func calculateStudentAverage(){
    if students.count == 0 {
        print("No students available. Add students first.\n")
        return
    }
    
    var validLookup = false
    
    // Loop until valid student ID is found
    while validLookup == false {
        print("Enter the student ID to calculate average grade: ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter a student ID.")
        } else if let studentID = Int(input) {
            var found = false
            
            // Search for student with matching ID
            for student in students {
                if student.studentID == studentID {
                    print("Average grade for \(student.name): \(student.averageGrade())")
                    found = true
                    validLookup = true
                    break
                }
            }
            
            // Display available IDs if student not found
            if found == false {
                print("Error: No student found with ID \(studentID).")
                print("Available student IDs are: ", terminator: "")
                for i in 0..<students.count {
                    print(students[i].studentID, terminator: "")
                    if i < students.count - 1 {
                        print(", ", terminator: "")
                    }
                }
                print()
            }
        } else {
            print("Error: Please enter a valid number.")
        }
    }
    print()
}

//Prompt user for Threshold grade and display users that are passing/failing - handles errors
func displayPassingFailingStudents(){
    if students.count == 0 {
        print("No students available. Add students first.\n")
        return
    }
    
    var validThreshold = false
    
    // Loop until valid threshold is entered
    while validThreshold == false {
        print("Enter the threshold to determine passing or failing students: ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter a threshold number.")
        } else if let thresholdValue = Double(input) {
            if thresholdValue >= MIN_GRADE && thresholdValue <= MAX_GRADE {
                threshold = thresholdValue
                validThreshold = true
            } else {
                print("Error: Threshold should be between \(MIN_GRADE) and \(MAX_GRADE).")
            }
        } else {
            print("Error: Please enter a valid number.")
        }
    }
    
    // Categorize students based on their performance
    var passingStudents: [Student] = []
    var failingStudents: [Student] = []
    
    for student in students {
        if student.isPassing() {
            passingStudents.append(student)
        } else {
            failingStudents.append(student)
        }
    }
    
    // Display results
    print("Threshold: \(threshold)")
    print("Passing students:")
    if passingStudents.count == 0 {
        print("  None")
    } else {
        for student in passingStudents {
            print("  \(student.studentID): \(student.name)")
        }
    }
    
    print("Failing students:")
    if failingStudents.count == 0 {
        print("  None")
    } else {
        for student in failingStudents {
            print("  \(student.studentID): \(student.name)")
        }
    }
    print()
}

// Main program loop - continues until user chooses to exit
while true {
    menuPopup()
    print("Enter your choice:")
    let choice = readLine() ?? ""
    
    // take users selection
    if let option = Int(choice) {
        switch option {
        case 1:
            addStudent()
        case 2:
            listStudents()
        case 3:
            calculateStudentAverage()
        case 4:
            displayPassingFailingStudents()
        case 5:
            print("Exiting the program. Goodbye!")
            exit(0)
        default:
            print("Invalid choice. Please enter a number between 1 and 5.\n")
        }
    } else {
        print("Invalid input. Please enter a number between 1 and 5.\n")
    }
}
