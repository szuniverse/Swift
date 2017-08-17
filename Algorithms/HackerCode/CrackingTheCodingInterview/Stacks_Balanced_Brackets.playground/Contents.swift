//: Playground - noun: a place where people can play

import UIKit

// https://www.hackerrank.com/challenges/ctci-balanced-brackets/problem

//import Foundation
//
//// Enter your code here
//
//// read the integer n
//let n = Int(readLine()!)!
//
//// read array

// Helper enum for left and right brackets

extension String {
    
    func isRightBr() -> Bool {
        return self == Br.Right.br1.rawValue || self == Br.Right.br2.rawValue || self == Br.Right.br3.rawValue
    }
    
    func isLeftBr() -> Bool {
        return self == Br.Left.br1.rawValue || self == Br.Left.br2.rawValue || self == Br.Left.br3.rawValue
    }
}

enum Br {
    
    enum Left: String {
        case br1 = "("
        case br2 = "{"
        case br3 = "["
    }
    
    enum Right: String {
        case br1 = ")"
        case br2 = "}"
        case br3 = "]"
    }
    
    static func isBr(_ str: String) -> Bool {
        return str.isLeftBr() || str.isRightBr()
    }
    
    static func rightPair(_ leftBr: Br.Left) -> Br.Right {
        switch leftBr {
        case Br.Left.br1:
            return Right.br1
        case Br.Left.br2:
            return Right.br2
        case Br.Left.br3:
            return Right.br3
        }
    }
}

func isBalanced(_ str: String) -> String {
    
    let strArray = str.characters.map { String($0) }
    
    //    if let firstCh = strArray.first, firstCh.isRightBr() {
    //        return "NO"
    //    }
    
    var leftBr1Count = 0
    var leftBr2Count = 0
    var leftBr3Count = 0
    
    var orderedBrs = [String]()

    for ch in strArray.enumerated() {
        
        let strCh = String(ch.element)!
        
        
        if let left = Br.Left(rawValue: strCh) {
            
            switch left {
            case .br1:
                leftBr1Count += 1
            case .br2:
                leftBr2Count += 1
            case .br3:
                leftBr3Count += 1
            }
            
            orderedBrs.append(strCh)
            
        } else if let right = Br.Right(rawValue: strCh) {
            switch right {
            case .br1:
                leftBr1Count -= 1
            case .br2:
                leftBr2Count -= 1
            case .br3:
                leftBr3Count -= 1
            }
            
            if let last = orderedBrs.last {

                if Br.rightPair(Br.Left(rawValue: last)!) != right {
                    return "NO"
                }
                
                orderedBrs.removeLast()
            }
            
        }
        
        if leftBr1Count < 0 || leftBr1Count < 0 || leftBr1Count < 0 {
            return "NO"
        }
        
    }
    
    return "YES"
}


//for i in 0..<n {
//    let str = String(readLine()!)!
//    print(isBalanced(str))
//}


//
//isBalanced("[](){()}")
isBalanced("{[(])}")

