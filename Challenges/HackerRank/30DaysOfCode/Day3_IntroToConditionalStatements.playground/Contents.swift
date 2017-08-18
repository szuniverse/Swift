//: Playground - noun: a place where people can play

import UIKit



let n = 3

if n % 2 == 1 {
    print("Weird")
}
else {
    if n > 2 && n < 5 {
        print("Not Weird")
    } else if n > 2 && n < 5 {
        print("Weird")
    } else {
        print("Not Weird")
    }
}

//If  is odd, print Weird
//If  is even and in the inclusive range of  to , print Not Weird
//If  is even and in the inclusive range of  to , print Weird
//If  is even and greater than , print Not Weird
