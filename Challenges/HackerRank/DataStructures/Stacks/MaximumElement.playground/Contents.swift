//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/maximum-element/problem

import Foundation

struct Stack<T: Comparable> {
    fileprivate var array = [T]()
    fileprivate var max = [T]()
    
    mutating func push(_ element: T) {
        if let last = max.last, element >= last  {
            max.append(element)
        } else if max.count == 0 {
            max.append(element)
        }
        array.append(element)
    }
    
    mutating func pop() {
        if let last = array.popLast(), let lastMax = max.last, last == lastMax {
            max.removeLast()
        }
    }
    
    mutating func findMax() -> T? {
        if let max = max.last {
            return max
        }
        return nil
    }
    
}

let n = Int(readLine()!)!
var stack = Stack<Int>()

for i in 0..<n {
    var arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
    let action = arr[0]
    switch action {
    case 1:
        let number = arr[1]
        stack.push(number)
    case 2:
        stack.pop()
    case 3:
        if let max = stack.findMax() {
            print(max)
        }
    default:
        break
    }
}