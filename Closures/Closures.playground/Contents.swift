//: Playground - noun: a place where people can play

import UIKit


// https://cocoacasts.com/30-days-of-swift-closures/

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let filteredNumbers0 = numbers.filter({ (number: Int) -> Bool in return (number % 2) == 0 })
let filteredNumbers1 = numbers.filter({ (number: Int) in return (number % 2) == 0 })
let filteredNumbers2 = numbers.filter({ (number) in return (number % 2) == 0 })
let filteredNumbers3 = numbers.filter({ (number) in (number % 2) == 0 })
let filteredNumbers4 = numbers.filter({ ($0 % 2) == 0 })
let filteredNumbers5 = numbers.filter { ($0 % 2) == 0 } // trailing closures