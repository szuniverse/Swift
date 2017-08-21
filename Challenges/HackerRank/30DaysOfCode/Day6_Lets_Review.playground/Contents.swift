//: Playground - noun: a place where people can play

// https://www.hackerrank.com/challenges/30-review-loop/problem

import Foundation

let numStrings = Int(readLine()!)!

func printEvenAndOdd(string: String) {
    var odd = ""
    var even = ""
    for value in string.characters.enumerated() {
        if Double(value.offset).truncatingRemainder(dividingBy: 2) == 1 {
            odd = odd + "\(value.element)"
        } else {
            even = even + "\(value.element)"
        }
    }
    print(even + " " + odd)
}

for _ in 1...numStrings {
    let inputString = readLine()!
    printEvenAndOdd(string: inputString)
}