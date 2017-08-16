//: Playground - noun: a place where people can play

// https://github.com/raywenderlich/swift-algorithm-club/tree/master/Stack
import UIKit

// LIFO
public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

var stack = Stack<Int>()
stack.push(5)
print(stack)

stack.pop()
print(stack)

stack.push(5)
stack.push(8)
stack.push(2)
print(stack)

stack.pop()
print(stack)




