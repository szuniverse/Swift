//: Playground - noun: a place where people can play

import UIKit

protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}

extension Bird {
    // Flyable birds can fly!
    var canFly: Bool { return self is Flyable }
}

extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I’ll just sit here :["
    }
}

// STRUCT
struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double
    
    // Swift is FASTER every version!
    var airspeedVelocity: Double { return version * 1000.0 }
}


// ENUM
enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}

extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}


UnladenSwallow.unknown.canFly  // false
UnladenSwallow.african.canFly  // true
Penguin(name: "King Penguin").canFly  // false
UnladenSwallow.african

let numbers = [10,20,30,40,50,60]
let slice = numbers[1...3]
let reversedSlice = slice.reversed()

let answer = reversedSlice.map { $0 * 10 }
print(answer)

// CLASS
class Motorcycle {
    init(name: String) {
        self.name = name
        speed = 200
    }
    var name: String
    var speed: Double
}

protocol Racer {
    var speed: Double { get }  // speed is the only thing racers care about
}

extension FlappyBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        return 42  // full waddle speed
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airspeedVelocity : 0
    }
}

extension Motorcycle: Racer {}

let racers: [Racer] =
    [UnladenSwallow.african,
     UnladenSwallow.european,
     UnladenSwallow.unknown,
     Penguin(name: "King Penguin"),
     SwiftBird(version: 3.0),
     FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
     Motorcycle(name: "Giacomo")
]

/////
func topSpeed(of racers: [Racer]) -> Double {
    return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
}

func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double
    where RacerType.Iterator.Element == Racer {
        return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
}

topSpeed(of: racers)
topSpeed(of: racers[1...3]) // ERROR

/////
extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        return self.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
}

racers.topSpeed()        // 3000
racers[1...3].topSpeed()


/////
protocol Score: Equatable, Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    let value: Int
    
    static func ==(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value < rhs.value
    }
}

RacingScore(value: 150) >= RacingScore(value: 130)  // true


