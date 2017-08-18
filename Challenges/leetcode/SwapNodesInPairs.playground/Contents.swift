//: Playground - noun: a place where people can play

import UIKit

// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension ListNode {
    
    func printNodes() {
        var currentNode: ListNode? = self
        while currentNode != nil {
            print("\(String(describing: currentNode?.val)) -> ")
            currentNode = currentNode?.next
        }
    }
    
    func swap() -> ListNode {
        
        var swapped: ListNode?
        if let first = self.next?.val {
            swapped = ListNode(first)
        }
        
        guard let swap = swapped else {
            return ListNode(val)
        }
        swap.next = ListNode(val)
        return swap
        
    }
}

class Solution {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        var currentNode = head
        var buffer: [ListNode] = []
        
        while currentNode != nil {
            
            
            if let swapped = currentNode?.swap() {
                buffer.append(swapped)
            }
            currentNode = currentNode?.next?.next
        }
        
        for i in 0..<buffer.count - 1 {
            buffer[i].next?.next = buffer[i+1]
        }
        return buffer[0]
    }
}

class Solutionn {
    
    func swap(_ node: ListNode) -> ListNode {
        
        var swapped: ListNode?
        if let first = node.next?.val {
            swapped = ListNode(first)
        }
        
        guard let swap = swapped else {
            return ListNode(node.val)
        }
        swap.next = ListNode(node.val)
        return swap
        
    }
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        
        guard let head = head else {
            return nil
        }
        var currentNode: ListNode? = head
        var buffer: [ListNode] = []
        
        while currentNode != nil {
            let swapped = swap(currentNode!)
            buffer.append(swapped)
            currentNode = currentNode!.next?.next
        }
        for i in 0..<buffer.count - 1 {
            buffer[i].next?.next = buffer[i+1]
        }
        return buffer[0]
    }
}
let l10 = ListNode(1)
let l11 = ListNode(2)
let l12 = ListNode(3)
let l13 = ListNode(4)

l10.next = l11
l11.next = l12
l12.next = l13

let s = Solutionn()
s.swapPairs(nil)?.printNodes()
//l12.swap().printNodes()

