//: Playground - noun: a place where people can play

import UIKit

// https://www.careercup.com/question?id=5664081785651200

print("asd")
let array1 = [2,3,1]
let array2 = [2,5,3]
let array3 = [7,3,1]

let set1:Set<Int> = Set(array1)
let set2:Set<Int> = Set(array2)
let set3:Set<Int> = Set(array3)

let intersect = set1.intersection(set2)
print(intersect)
