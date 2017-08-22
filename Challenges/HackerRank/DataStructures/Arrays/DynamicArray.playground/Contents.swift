//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/dynamic-array/problem

import Foundation

// read array
var initArr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
let n = initArr[0]
let row = initArr[1]
var lastAnswer = 0

var s0 = [Int]()
var s1 = [Int]()
var s = [s0, s1]

for i in 0..<row {
    var arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
    let x = arr[1]
    let value = arr[2]
    let seq = Double(x ^ lastAnswer).truncatingRemainder(dividingBy: Double(n))
    lastAnswer = Int(seq)
    s[Int(seq)].append(value)
    
}
print(s)