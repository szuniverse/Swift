//: Playground - noun: a place where people can play

import UIKit

class Object {}
class AObject: Object {
    func deepDesc() {
        print("A")
    }
}
class BObject: Object {
    func deepDesc() {
        print("B")
    }
}

class StorageService<T> {
    
    func numberOf() -> Int {
        if T.self == AObject.self {
            return 99
        }
        return 1
    }
}

class Presenter<T: Object> {
    
    var service = StorageService<T>()
    
    func numberOfValami() -> Int {
        return service.numberOf()
    }
}


class BasePresenter {

    let presenter: Any

    init<T>(thing: Presenter<T>) {
        presenter = thing
    }
}

class ViewController {
    
    let d1 = BasePresenter(thing: Presenter<BObject>.init())
    let currentType = AObject.self
    
    func didLoad() {
//        let d2 = BasePresenter<ViewController>(thing: Presenter<ViewController, BObject>.init())
//        var dict = [String: BasePresenter<ViewController>]()
//        dict["d1"] = d1
//        dict["d2"] = d2
        print(type(of: currentType))
        print((d1.presenter as! Presenter<BObject>).numberOfValami())
    }
}





let v = ViewController()
v.didLoad()

