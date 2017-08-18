//: Playground - noun: a place where people can play

// https://www.hackerrank.com/challenges/the-hurdle-race/problem

import Foundation

var arr1 = readLine()!.components(separatedBy: " ").map{ Int($0)! }
var arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }

let d = arr1[1]
let max = arr.max() ?? 0
if max == 0 { print(0) }
let dist = max - d
if dist >= 0 {
    print(dist)
} else {
    print(0)
}