//: Playground - noun: a place where people can play

import UIKit

//https://leetcode.com/problems/add-two-numbers/description/


//* Definition for singly-linked list.
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
            print("\(val) ")
            currentNode = currentNode?.next
        }
    }
    
    func removeFirst() -> ListNode? {
        let nodes = next
        
        var currentNode = nodes
        
        while currentNode != nil {
            currentNode = currentNode?.next
        }
        return nodes
    }
}

class Solution {
    // 2 4 3
    // 5 6 4
    func addTwoNumbersRecursive(_ l1: ListNode?, _ l2: ListNode?, _ sumNode: ListNode? = nil) -> ListNode? {
    
        var ssNode: ListNode! = sumNode
        if sumNode == nil {
            ssNode = ListNode((l1?.val ?? 0) + (l2?.val ?? 0))
        }
        if l1 == nil && l2 == nil {
            return ssNode
        }
    
//        let currentListNode = ListNode((l1?.next?.val ?? 0) + (l2?.next?.val ?? 0))
//        ssNode?. = currentListNode
        
        return addTwoNumbersRecursive(l1?.removeFirst(), l2?.removeFirst(), ssNode.next)
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        if l1 == nil && l2 == nil {
            return nil
        }
        
        let returnListNode: ListNode = ListNode((l1?.val ?? 0) + (l2?.val ?? 0))
        var currentNode: ListNode? = returnListNode
        var next1: ListNode? = l1?.next
        var next2: ListNode? = l2?.next
        var remainder: Int = 0
        
        while currentNode != nil {
            
            remainder = (((currentNode?.val ?? 0) / 10) % 10)
            currentNode?.val = (currentNode?.val ?? 0) % 10
            
            if remainder > 0 || next1?.val != nil || next2?.val != nil {
                currentNode?.next = ListNode((next1?.val ?? 0) + (next2?.val ?? 0) + remainder)
            }
            
            next1 = next1?.next
            next2 = next2?.next
            currentNode = currentNode?.next
        }
        return returnListNode
    }
}

let l10 = ListNode(2)
let l11 = ListNode(4)
let l12 = ListNode(3)

let l20 = ListNode(5)
let l21 = ListNode(6)
let l22 = ListNode(4)

l10.next = l11
l11.next = l12

l20.next = l21
l21.next = l22

let s = Solution()

let r = s.addTwoNumbers(l10, l20)
//print(r?.val)
//print(r?.next?.val)
//print(r?.next?.next?.val)

let r2 = s.addTwoNumbersRecursive(l10, l20)
print(r2?.printNodes())

//print(l10.removeFirst()?.val)
//print(l10.removeFirst()?.next?.val)
//print(l10.removeFirst()?.next?.next?.val)


