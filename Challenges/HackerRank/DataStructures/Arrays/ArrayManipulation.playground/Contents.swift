//: Playground - noun: a place where people can play

import Foundation

// https://www.hackerrank.com/challenges/crush/problem

let firstRow = readLine()!.components(separatedBy: " ").map{ Int($0)! }
let length = firstRow[0]
let rows = firstRow[1]

var array = Array(repeating: 0, count: length)
var max = 0

for i in 0..<rows {
    let criteria = readLine()!.components(separatedBy: " ").map{ Int($0)! }
    let start = criteria[0] - 1
    let end = criteria[1] - 1
    let value = criteria[2]
    
    var sliceArray = Array(array[start...end])
    
    for j in 0..<sliceArray.count {
        sliceArray[j] += value
        let jV = sliceArray[j]
        max = jV > max ? jV : max
    }
    array.replaceSubrange(Range(start...end), with: Array(sliceArray))
}

print(max)