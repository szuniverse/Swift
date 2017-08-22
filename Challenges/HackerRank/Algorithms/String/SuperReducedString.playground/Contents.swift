//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/reduced-string/problem

let str = "aaabaaa"
var arr = [String]()

for value in str.characters {
    
    if let last = arr.last, last == String(value) {
        arr.removeLast()
    } else {
        arr.append("\(value)")
    }
}

var resultStr = ""
for value in arr {
    resultStr = resultStr + value
}

if resultStr.characters.count == 0 {
    print("Empty String")
} else {
    print(resultStr)
}
