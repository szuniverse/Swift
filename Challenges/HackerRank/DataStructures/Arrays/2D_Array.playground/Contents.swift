//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/2d-array/problem

var arr: [[Int]] = [
    [1, 1, 1, 0, 0, 0],
    [0, 1, 0, 0, 0, 0],
    [1, 1, 1, 0, 0, 0],
    [0, 0, 2, 4, 4, 0],
    [0, 0, 0, 2, 0, 0],
    [0, 0, 1, 2, 4, 0]
]

// index x, y
func hourglassNumbers(x: Int, y: Int, array: [[Int]]) -> Int {
    var sum = 0
//    print("x: \(x)")
//    print("y: \(y)")

    for xx in x-1...x+1 {
        
        for yy in y-1...y+1 {
//            print("x: \(xx) y: \(yy) v: \(array[yy][xx])")
            if !((xx == x-1 && yy == y) || (xx == x+1 && yy == y)) {
                sum += array[yy][xx]
            }
        }

    }

    return sum
}

var sums = [Int]()
for x in 1..<5 {
    for y in 1..<5 {
        var h = hourglassNumbers(x: x, y: y, array: arr)
        sums.append(h)
//        print("=======")

    }
}
print(sums.max()!)

//x: 4
//y: 4
//x: 3 - y: 3 - v: -4
//x: 4 - y: 3 - v: -4
//x: 5 - y: 3 - v: 0
//  x: 3 - y: 4 - v: -2
//x: 4 - y: 4 - v: 0
//  x: 5 - y: 4 - v: 0
//x: 3 - y: 5 - v: -2
//x: 4 - y: 5 - v: -4
//x: 5 - y: 5 - v: 0
