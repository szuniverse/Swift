//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/sparse-arrays/problem

//var array = ["aba", "baba", "aba", "xzxb"]
//var find = ["aba", "xzxb", "ab"]//for i in 0..<n {


// read the integer n
let n = Int(readLine()!)!
var array = [String]()
for i in 0..<n {
    var str = String(readLine()!)!
    array.append(str)
}

let m = Int(readLine()!)!
var find = [String]()
for i in 0..<m {
    var str = String(readLine()!)!
    find.append(str)
}

for value in find.enumerated() {
    let count = array.filter({ $0 == value.element }).count
    print(count)
}