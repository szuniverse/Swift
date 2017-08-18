//: Playground - noun: a place where people can play

import UIKit

// Median of Two Sorted Arrays
// https://leetcode.com/problems/median-of-two-sorted-arrays/description/

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let array = (nums1 + nums2).sorted()
        var half: Double = Double(array.count / 2)
        
        if array.count % 2 == 0 {
            half -= 1
            let firstElement: Double = Double(array[Int(half)])
            let secondElement: Double = Double(array[Int(half + 1)])
            return (firstElement + secondElement) / 2
        } else {
            return Double(array[Int(ceil(Double(half)))])
        }
    }
}

let s = Solution()
print(s.findMedianSortedArrays([1, 3], [2])) // 2
print(s.findMedianSortedArrays([1, 2], [3, 4])) // 2.5
print(s.findMedianSortedArrays([], [2, 3])) // 2.5
