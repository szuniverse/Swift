import Foundation

//https://www.hackerrank.com/challenges/ctci-big-o/problem

// Enter your code here
let n = Int(readLine()!)!
var arr = [Int]()

func isPrimeNumber(_ number: Int) -> String {
    
    // Pre-check
    if number < 0 {
        return "Not prime"
    }
    
    if number == 2{
        return "Prime"
    }
    
    // right below
    let maxDivider = Int(sqrt(Double(number)))
    let isPrime = number > 1 && !(2...maxDivider).contains { number % $0 == 0 }
    
    //let isPrime = number > 1 && !(2..<number).contains { number % $0 == 0 }
    return isPrime ? "Prime" : "Not prime"
}

for i in 0..<n {
    let num = Int(readLine()!)!
    print(isPrimeNumber(num))
}
