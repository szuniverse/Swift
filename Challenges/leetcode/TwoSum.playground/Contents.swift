//: Playground - noun: a place where people can play

import UIKit

//https://leetcode.com/problems/two-sum/

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // optimize for odd target
        var oddNumbers = [String: Int]()
        if target % 2 == 1 {
            for i in (0..<nums.count) {
                let int = nums[i]
                if int % 2 == 1 {
                    oddNumbers["\(int)"] = i
                }
            }
        }
        
        for (key, value) in oddNumbers {
            if let index = nums.index(of: target - Int(key)!) {
                return [index, value].sorted()
            }
        }
        
        
        // calculate if target is not odd
        for i in (0..<nums.count).reversed() {
            let firstNumber = nums[i]
            let rest = target - firstNumber
            
            let indexes = nums.enumerated().filter {
                $0.element == rest
                }.map{$0.offset}
            
            if indexes.count > 1 {
                return indexes
            }
            
            if let restIndex = nums.index(of: rest) {
                if rest == firstNumber { continue }
                return [i, restIndex].sorted()
            }
        }
        return []
    }
}

//Given nums = [2, 7, 11, 15], target = 9,
//0, 1

let s = Solution()
s.twoSum([2, 11, 7, 15], 9) // 0 2
s.twoSum([3, 2, 4], 6) // 1 2
s.twoSum([0, 4, 3, 0], 0) // 0 3
s.twoSum([7, 4, 3, 7], 14) // 0 3
s.twoSum([-1,-2,-3,-4,-5], -8)

