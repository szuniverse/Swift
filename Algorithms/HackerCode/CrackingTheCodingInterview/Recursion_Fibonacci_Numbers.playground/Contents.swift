//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/ctci-fibonacci-numbers/problem

func fibonacci (n: Int) -> Int {
    // Write your code here.
    var array = [0,1]
    var i = 0
    while i != n - 1 {
        let next = array[i] + array[i + 1]
        array.append(next)
        i += 1
    }
    
    return array.last!
}

// read the integer n
let n = Int(readLine()!)!

// print the nth fibonacci number
print(fibonacci(n: n))
