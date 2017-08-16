//: Playground - noun: a place where people can play

// https://www.raywenderlich.com/139591/building-custom-collection-swift

import UIKit

struct Bag<Element: Hashable> {
  
    // 1
    fileprivate var contents: [Element: Int] = [:]
    
    // 2
    var uniqueCount: Int {
        return contents.count
    }
    
    // 3
    var totalCount: Int {
        return contents.values.reduce(0) { $0 + $1 }
    }
    
    // 1
    mutating func add(_ member: Element, occurrences: Int = 1) {
        // 2
        precondition(occurrences > 0, "Can only add a positive number of occurrences")
        
        // 3
        if let currentCount = contents[member] {
            contents[member] = currentCount + occurrences
        } else {
            contents[member] = occurrences
        }
    }
}

