//: Playground - noun: a place where people can play

// https://www.hackerrank.com/challenges/30-arrays/problem

import Foundation

// number of elements
let n = Int(readLine()!)!

// read array
let arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
var str = ""
for i in 0..<arr.count {
    str = str + "\(arr[arr.count - 1 - i])" + " "
}

print(str)
