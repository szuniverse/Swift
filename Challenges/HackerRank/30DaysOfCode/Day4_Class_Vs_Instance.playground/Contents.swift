//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/30-class-vs-instance/problem

class Person {
    var age: Int = 0
    
    init(initialAge: Int) {
        self.age = initialAge
        if self.age < 0 {
            self.age = 0
            print("Age is not valid, setting age to 0.")
        }
        // Add some more code to run some checks on initialAge
    }
    
    func amIOld() {
        if age < 13 {
            print("You are young.")
        } else if age >= 13 && age < 18 {
            print("You are a teenager.")
        } else {
            print("You are old.")
        }
        // Do some computations in here and print out the correct statement to the console
    }
    
    func yearPasses() {
        // Increment the age of the person in here
        age += 1
    }
}

//If , print You are young..
//If  and , print You are a teenager..
//Otherwise, print You are old..