//: Playground - noun: a place where people can play

// https://www.hackerrank.com/challenges/30-operators/problem
import Foundation

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

let mealCost = Float(readLine()!)!
let tipPercent = Float(readLine()!)!
let taxPercent = Float(readLine()!)!

let tip = mealCost * tipPercent / 100
let tax = mealCost * taxPercent / 100
var sum = (mealCost + tip + tax).rounded()
print("The total meal cost is \(sum.clean) dollars.")
