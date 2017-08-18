//: Playground - noun: a place where people can play

import UIKit
// http://waynewbishop.com/swift/recursion/

func fibRecursive(_ n: Int, sequence: Array<Int> = [0, 1]) -> [Int]? {
    
    //check trivial condition
    guard n > 2 else {
        return nil
    }
    
    //mutated copy
    var output = sequence
    let i: Int = output.count
    
    //set base condition
    if i == n {
        return output
    }
    
    let results: Int = output[i - 1] + output[i - 2]
    output.append(results)
    
    //set iteration
    return fibRecursive(n, sequence: output)
}

print(fibRecursive(2+4+1))
