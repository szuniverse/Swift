// Enter your code here. Read input from STDIN. Print output to STDOUT
import Foundation

// https://www.hackerrank.com/challenges/30-dictionaries-and-maps/problem
let n = Int(readLine()!)!

var phoneBook = [String: String]()
for _ in 0..<n {
    let item = readLine()!.components(separatedBy: " ").map{ String($0)! }
    let key = item[0]
    let value = item[1]
    phoneBook[key] = value
}

var line = readLine()
while line != nil {
    let str = String(line!)!
    if phoneBook[str] != nil {
        print("\(str)=\(phoneBook[str]!)")
    } else {
        print("Not found")
    }
    line = readLine()
}