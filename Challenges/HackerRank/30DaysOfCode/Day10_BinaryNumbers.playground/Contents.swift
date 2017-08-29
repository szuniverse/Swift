//: Playground - noun: a place where people can play

import UIKit
// https://www.hackerrank.com/challenges/30-binary-numbers/problem
import Foundation

let num = Int(readLine()!)!
let str = String(num, radix: 2)

var maximum = 1
var localMax = 1
var prevChar = ""
for currentChar in str.characters {
    
    if String(currentChar) == "1" && prevChar == "1" {
        localMax += 1
    } else {
        localMax = 1
    }
    
    if localMax > maximum {
        maximum = localMax
    }
    
    prevChar = String(currentChar)
}
print(maximum)
