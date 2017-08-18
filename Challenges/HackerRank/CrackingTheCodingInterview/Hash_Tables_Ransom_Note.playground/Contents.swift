//: Playground - noun: a place where people can play

import Foundation

// https://www.hackerrank.com/challenges/ctci-ransom-note/problem
//let n = readLine()!.components(separatedBy: " ").map{ Int($0)! }
//var arrMagazine = readLine()!.components(separatedBy: " ").map{ String($0)! }
//var arrNote = readLine()!.components(separatedBy: " ").map{ String($0)! }

var arrMagazine = "o l x imjaw bee khmla v o v o imjaw l khmla imjaw x".components(separatedBy: " ").map{ String($0)! }
var arrNote = "imjaw l khmla x imjaw o l l o khmla v bee o o imjaw imjaw o".components(separatedBy: " ").map{ String($0)! }

var arrDict = [String: Int]()

for i in 0..<arrMagazine.count {
    if arrDict[arrMagazine[i]] != nil {
        arrDict[arrMagazine[i]]! += 1
    } else {
        arrDict[arrMagazine[i]] = 1
    }
}

var isUntraceable = "Yes"
for i in 0..<arrNote.count {
    if arrDict[arrNote[i]] != nil {
        arrDict[arrNote[i]]! -= 1
        if arrDict[arrNote[i]]! < 0 {
            isUntraceable = "No"
            break
        }
    }
}
print(isUntraceable)