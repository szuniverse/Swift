//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/cats-and-a-mouse/problem

let n = Int(readLine()!)!

func calculateDistance(catA a: Int, catB b: Int, mouse m: Int) {
    
    let amDistance = abs(a - m)
    let bmDistance = abs(b - m)
    if amDistance == bmDistance {
        print("Mouse C")
    } else if amDistance > bmDistance {
        print("Cat B")
    } else {
        print("Cat A")
    }
    
}

// read array
for i in 0..<n {
    var arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
    var catA = arr[0]
    var catB = arr[1]
    var mouse = arr[2]
    calculateDistance(catA: catA, catB: catB, mouse: mouse)
}

