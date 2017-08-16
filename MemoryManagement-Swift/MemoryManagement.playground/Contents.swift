//: Playground - noun: a place where people can play

// https://www.raywenderlich.com/134411/arc-memory-management-swift

import UIKit

class User {
    var name: String
    private(set) var phones: [Phone] = []
    
    func add(phone: Phone) {
        phones.append(phone)
        phone.owner = self
    }
    
    init(name: String) {
        self.name = name
        print("User \(name) is initialized")
    }
    
    deinit {
        print("User \(name) is being deallocated")
    }
}

class Phone {
    let model: String
    var owner: User?
    
    init(model: String) {
        self.model = model
        print("Phone \(model) is initialized")
    }
    
    deinit {
        print("Phone \(model) is being deallocated")
    }
}

do {
    let user1 = User(name: "John")
    let iPhone = Phone(model: "iPhone 6s Plus")
    user1.add(phone: iPhone)
}