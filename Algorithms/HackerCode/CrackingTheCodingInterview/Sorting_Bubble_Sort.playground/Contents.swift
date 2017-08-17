//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/ctci-bubble-sort/problem



// read the array
var a = [7,1,3,2,5,4]
let n = a.count

func swap(_ index: Int, _ withIndex: Int, _ array: [Int]) -> [Int] {
    
    var a = array
    let first = a.remove(at: index)
    let second = a.remove(at: withIndex - 1)
    
//    print(a)

    a.insert(second, at: index)
    a.insert(first, at: withIndex)
    
    return a

}

var all = 0
for i in 0..<a.count {
    // Track number of elements swapped during a single array traversal
    var numberOfSwaps = 0

    for j in 0..<(n - 1) {
        // Swap adjacent elements if they are in decreasing order
        if (a[j] > a[j + 1]) {
            a = swap(j, j + 1, a)
            numberOfSwaps += 1
        }
    }
    
    // If no elements were swapped during a traversal, array is sorted
    if (numberOfSwaps == 0) {
        break;
    }
    
    all += numberOfSwaps
}

print("Array is sorted in \(all) swaps.")
print("First Element: \(a.first!)")
print("Last Element: \(a.last!)")


