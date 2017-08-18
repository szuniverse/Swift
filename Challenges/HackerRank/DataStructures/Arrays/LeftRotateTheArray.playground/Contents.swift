//: Playground - noun: a place where people can play

import UIKit

var firstRow = [5,12]
var arr = [1, 2, 3, 4, 5]
var rotate = firstRow[1]

func rotation(_ r: Int, arr: inout [Int]) {
    print(r)
    let slice1 = arr[0...r-1]
    let slice2 = arr[r...arr.count-1]
    arr = Array(slice2 + slice1)
}

func pr(_ arr: [Int]) {
    var str = ""
    for value in arr.enumerated() {
        str = str + "\(value.element)" + " "
    }
    print(str)
}

var ratio: Float = Float(rotate) / Float(arr.count)

if ratio < 1 {
    rotation(rotate, arr: &arr)
} else if ratio > 1 {
    let realR = Int(Float(ratio).rounded(.towardZero))
    let a = realR * arr.count
    rotate = rotate - a
    rotation(rotate, arr: &arr)
}

pr(arr)
