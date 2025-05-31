//
//  main.swift
//  Assignment1
//
//  Created by Shawn Pearce on 2025-05-26.
//


import Foundation

//Create the Array and the threshold field

var students: [Student] = []
var threshold: Double = 0





//Create the Student class
class Student {
    let studentID: Int
    let name: String
    var grades: [Double]
    
    init(studentID: Int, name: String, grades: [Double]) {
        self.studentID = studentID
        self.name = name
        self.grades = grades
    }
    //Function to Calculate Average of grades
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
    //Function to check what students are padding based on the threshold
    func isPassing() -> Bool {
        return averageGrade() >= threshold
    }
}
//Function to display Menu
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
//Function to add student to the array
func addStudent(){
    var studentID: Int = 0
    var validID = false
    
    while validID == false {     //Error checks
        print("Enter student ID: ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter a student ID number.")
        }
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
    
    while validGrades == false {
        print("Enter grades separated by spaces (example: 85.5 90 78): ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter at least one grade.")
        } else {
            let gradeStrings = input.split(separator: " ")
            var tempGrades: [Double] = []
            var hasError = false
            
            for gradeString in gradeStrings {
                let gradeText = String(gradeString)
                
                if let grade = Double(gradeText) {
                    if grade >= 0 && grade <= 100 {
                        tempGrades.append(grade)
                    } else {
                        print("Error: Grade '\(gradeText)' must be between 0 and 100.")
                        hasError = true
                        break
                    }
                } else {
                    print("Error: '\(gradeText)' is not a valid number.")
                    hasError = true
                    break
                }
            }
            
            if hasError == false {
                grades = tempGrades
                validGrades = true
                print("Successfully added \(grades.count) grades.")
            }
        }
    }
    
    let student = Student(studentID: studentID, name: name, grades: grades)
    students.append(student)
    print("Student added successfully!\n")
}
//Function to dislay the list of students in the array
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

func calcAv(){ //finds specific student and displays their average grade
    if students.count == 0 {
        print("No students available. Add students first.\n")
        return
    }
    
    var validLookup = false
    
    while validLookup == false {
        print("Enter the student ID to calculate average grade: ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter a student ID.")
        } else if let studentID = Int(input) {
            var found = false
            for student in students {
                if student.studentID == studentID {
                    print("Average grade for \(student.name): \(student.averageGrade())")
                    found = true
                    validLookup = true
                    break
                }
            }
            
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

func passFail(){ //seperates students into pass fail groups
    if students.count == 0 {
        print("No students available. Add students first.\n")
        return
    }
    
    var validThreshold = false
    
    while validThreshold == false {
        print("Enter the threshold to determine passing or failing students: ")
        let input = readLine() ?? ""
        
        if input == "" {
            print("Error: Please enter a threshold number.")
        } else if let thresholdValue = Double(input) {
            if thresholdValue >= 0 && thresholdValue <= 100 {
                threshold = thresholdValue
                validThreshold = true
            } else {
                print("Error: Threshold should be between 0 and 100.")
            }
        } else {
            print("Error: Please enter a valid number.")
        }
    }
    
    var passingStudents: [Student] = []
    var failingStudents: [Student] = []
    
    for student in students {
        if student.isPassing() {
            passingStudents.append(student)
        } else {
            failingStudents.append(student)
        }
    }
    
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

//keeps program running until exit
while true {
    menuPopup()
    print("Enter your choice:")
    let choice = readLine() ?? ""
    
    if let option = Int(choice) {
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
            print("Invalid choice. Please enter a number between 1 and 5.\n")
        }
    } else {
        print("Invalid input. Please enter a number between 1 and 5.\n")
    }
}
