//: Playground - noun: a place where people can play


// https://www.raywenderlich.com/154371/swift-generics-tutorial-getting-started

import UIKit

func addInts(x: Int, y: Int) -> Int {
    return x + y
}
let intSum = addInts(x: 1, y: 2)
print(intSum)

func addDoubles(x: Double, y: Double) -> Double {
    return x + y
}
let doubleSum = addDoubles(x: 1.0, y: 2.0)
print(doubleSum)

let numbers = [1, 2, 3]
let firstNumber = numbers[0]

var numbersAgain: Array<Int> = []
numbersAgain.append(1)
numbersAgain.append(2)
numbersAgain.append(3)
let firstNumberAgain = numbersAgain[0]
//numbersAgain.append("All hail Lord Farquaad")

// MARK: - Dictionaries
// Optiona<String>
let countryCodes = ["Arendelle": "AR", "Genovia": "GN", "Freedonia": "FD"]
let countryCode = countryCodes["Freedonia"]

let optionalName = Optional<String>.some("Princess Moana")
if let name = optionalName {}

// MARK: - Writing a Generic Data Structure
struct Queue<Element> {
    fileprivate var elements: [Element] = []
    
    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
}

var q = Queue<Int>()

q.enqueue(newElement: 4)
q.enqueue(newElement: 2)

q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()

// MARK: Writing a Generic Function
func pairs<Key, Value>(from dictionary: [Key: Value]) -> [(Key, Value)] {
    return Array(dictionary)
}
let somePairs = pairs(from: ["minimum": 199, "maximum": 299])
// result is [("maximum", 299), ("minimum", 199)]

let morePairs = pairs(from: [1: "Swift", 2: "Generics", 3: "Rule"])
// result is [(2, "Generics"), (3, "Rule"), (1, "Swift")]

// MARK: - Constraining a Generic Type
func mid<T: Comparable>(array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    return array.sorted()[(array.count - 1) / 2]
}
mid(array: [3, 5, 1, 2, 4]) // 3

protocol Summable {
    static func +(lhs: Self, rhs: Self) -> Self
}
extension Int: Summable {}
extension Double: Summable {}

func add<T: Summable>(x: T, y: T) -> T {
    return x + y
}


let addIntSum = add(x: 1, y: 2) // 3
let addDoubleSum = add(x: 1.0, y: 2.0) // 3

extension String: Summable {}
let addString = add(x: "Generics", y: " are Awesome!!! :]")

// MARK: - Extending a Generic Type
extension Queue {
    func peek() -> Element? {
        return elements.first
    }
}
q.enqueue(newElement: 5)
q.enqueue(newElement: 3)
q.peek() // 5

// MARK: - Subclassing a Generic Type
class Box<T> {
    // Just a plain old box.
}

class Gift<T>: Box<T> {
    // By default, a gift box is wrapped with plain white paper
    func wrap() {
        print("Wrap with plain white paper.")
    }
}

class Rose {
    // Flower of choice for fairytale dramas
}

class ValentinesBox: Gift<Rose> {
    // A rose for your valentine
    override func wrap() {
        print("Wrap with ♥♥♥ paper.")
    }
}

class Shoe {
    // Just regular footwear
}

class GlassSlipper: Shoe {
    // A single shoe, destined for a princess
}

class ShoeBox: Box<Shoe> {
    // A box that can contain shoes
}

let box = Box<Rose>() // A regular box that can contain a rose
let gift = Gift<Rose>() // A gift box that can contain a rose
let shoeBox = ShoeBox()
let valentines = ValentinesBox()
gift.wrap() // plain white paper
valentines.wrap() // ♥♥♥ paper

// MARK: - Enumerations With Associated Values
enum Result<Value> {
    case success(Value), failure(Error)
}

enum MathError: Error {
    case divisionByZero
}

func divide(_ x: Int, by y: Int) -> Result<Int> {
    guard y != 0 else {
        return .failure(MathError.divisionByZero)
    }
    return .success(x / y)
}

let result1 = divide(42, by: 2) // .success(21)
let result2 = divide(42, by: 0) // .failure(MathError.divisionByZero)


// Associated type
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
