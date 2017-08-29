//: Playground - noun: a place where people can play

import UIKit
// https://www.hackerrank.com/challenges/30-recursion/problem
import Foundation

// Enter your code here
let k = Int(readLine()!)!

func factorial(max: Int, result: Int) -> Int {
    let c = max
    let p = max - 1
    let s = c * p * result
    if max <= 1 {
        return result
    }
    return factorial(max: p - 1, result: s)
}

let f = factorial(max: k, result: 1)
print(f)
