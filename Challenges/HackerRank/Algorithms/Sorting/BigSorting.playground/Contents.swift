//: Playground - noun: a place where people can play

import UIKit

//let n = Int(readLine()!)!

var arr = ["31", "30", "29", "41", "10", "3", "5"]


extension String {

    static func <<(lhs: String, rhs: String) -> Bool {
        if lhs.characters.count > rhs.characters.count {
            return false
        } else if lhs.characters.count < rhs.characters.count {
            return true
        } else if lhs.characters.count == rhs.characters.count {
            for i in 0..<lhs.characters.count {
                let st1 = String(Array(lhs.characters)[i])
                let st2 = String(Array(rhs.characters)[i])
                
                if Int(st1)! < Int(st2)! {
                    return true
                }
            }
        }

        return false
    }
    
    static func >>(lhs: String, rhs: String) -> Bool {
        if lhs.characters.count < rhs.characters.count {
            return false
        } else if lhs.characters.count > rhs.characters.count {
            return true
        } else if lhs.characters.count == rhs.characters.count {
            for i in 0..<lhs.characters.count {
                let st1 = String(Array(lhs.characters)[i])
                let st2 = String(Array(rhs.characters)[i])
                
                if Int(st1)! > Int(st2)! {
                    return true
                }
            }
        }
        
        return false
    }
}


func mergeSort(_ array: [String]) -> [String] {
    guard array.count > 1 else { return array }    // 1
    
    let middleIndex = array.count / 2              // 2
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))             // 3
    
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))  // 4
    
    return merge(leftPile: leftArray, rightPile: rightArray)             // 5
}

func merge(leftPile: [String], rightPile: [String]) -> [String] {
    // 1
    var leftIndex = 0
    var rightIndex = 0
    
    // 2
    var orderedPile = [String]()
    
    // 3
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] << rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] >> rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    // 4
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

print(mergeSort(["4", "1", "7", "45", "31415926535897932384626433832795", "7", "9",]))
