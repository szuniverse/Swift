//: Playground - noun: a place where people can play

import UIKit

// https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue

// FIFO
public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}

var queue = Queue<String>()
queue.enqueue("1. data pack")
queue.enqueue("2. data pack")
queue.enqueue("3. data pack")
print(queue)

queue.dequeue()
print(queue)
