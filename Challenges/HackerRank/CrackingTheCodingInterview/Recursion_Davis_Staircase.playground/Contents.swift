//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/ctci-recursive-staircase/problem

import Foundation

// read the integer n
let n = Int(readLine()!)!

func calculateSteps(_ steps: Int) -> Int {
    if steps < 0 {
        return 0
    } else if steps <= 1 {
        return 1
    } else if steps == 2 {
        return 2
    }
    
    var lastValues = [1, 1, 2] // 0
    
    for i in 3...steps {
        let count = lastValues[2] + lastValues[1] + lastValues[0]
        lastValues[0] = lastValues[1]
        lastValues[1] = lastValues[2]
        lastValues[2] = count
    }
    
    return lastValues[2]
}
for _ in 0..<n {
    let s = Int(readLine()!)!
    let steps = calculateSteps(s)
    print(steps)
}