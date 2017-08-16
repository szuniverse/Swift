//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func kisnagy(str: String) -> String {
    
    var newStr = ""
    var isLower = true
    
    
    for (_,value) in str.characters.enumerated() {
        
        if isLower {
            newStr += String(value).lowercased()
        }
        else {
            newStr += String(value).uppercased()
        }
        
        isLower = !isLower
        
        if value == " " {
            isLower = true
        }
    }
    
    return newStr
}


kisnagy(str: "egyy ket ha")