//: Playground - noun: a place where people can play

import UIKit
// https://www.hackerrank.com/challenges/30-2d-arrays/problem
import Foundation

var arr: [[Int]] = []
for i in 0..<6 {
    var line = readLine()!.components(separatedBy: " ").map{ Int($0)! }
    arr.append(line)
}

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
