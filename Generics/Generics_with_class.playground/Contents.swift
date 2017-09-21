//: Playground - noun: a place where people can play

import UIKit

class Object {}
class AObject: Object {
    func desc() {
        print("A")
    }
}
class BObject: Object {
    func desc() {
        print("B")
    }
}

protocol ViewProtocol {}

class Presenter<View: ViewProtocol, T: Object> {
    
    func value() -> Presenter<View, Object> {
        return self as! Presenter<View, Object>
    }
    
    func desc() {
        print("T desc")
    }
    
    lazy var pres = { return T.self }()
}


class BasePresenter<View: ViewProtocol> {
    
//    let presenter: Presenter<T>!
    
    let _presenter: () -> Presenter<View, Object>
    var presenter: Presenter<View, Object> { return _presenter() }
//    init<T: Flavor>(thing: Thing<T>) {
//        _value = { return thing.value }
//    }

    init<T>(thing: Presenter<View, T>) {
        _presenter = thing.value
    }
}

class ViewController: ViewProtocol {}
//var pr: Presenter<Object>!
//pr = Presenter<AObject>
//pr = Presenter<BObject>

let d1 = BasePresenter<ViewController>(thing: Presenter<ViewController, AObject>.init())
let d2 = BasePresenter<ViewController>(thing: Presenter<ViewController, BObject>.init())

//print(d1.presenter.pres)
//print(d2.presenter.pres)

//let d2 = BasePresenter(thing: Presenter<BObject>.init())
var dict = [String: BasePresenter<ViewController>]()
dict["d1"] = d1
dict["d2"] = d2
//print(dict)

