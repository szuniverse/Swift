//
//  ViewController.swift
//  TestEncodeDecode
//
//  Created by David Szurma on 9/6/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = Rectangle(width: 19)
        let ring = Ring(radius: 4)
        let scenedNodes = SceneNodes(shapes: [rect, ring])
        
        let encoder = JSONEncoder()
        let data = try? encoder.encode(scenedNodes)
        print(data!.toJSONString())
        
        let decoder = JSONDecoder()
        let scnFromData = try? decoder.decode(SceneNodes.self, from: data!)
        let data2 = try? encoder.encode(scnFromData)
        print(data2!.toJSONString())
        
    }
}

extension Data {
    func toJSONString() -> String {
        if let str = String(data: self, encoding: .utf8) {
            return str
        }
        fatalError("not valid json")
    }
}

enum BaseType: String, Codable {
    case rectangle
    case ring
    case unknown
}

class ShapeData: Codable {
    var type: BaseType
    var data: ControlableStruct
    
    init(type: BaseType, data: ControlableStruct) {
        self.type = type
        self.data = data
    }
    
    private enum CodingKeys : String, CodingKey {
        case type
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(BaseType.self, forKey: .type)
        data = try values.decode(ControlableStruct.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(data, forKey: .data)
    }
    
    func convertToClass() -> BaseControllable {
        switch type {
        case .rectangle:
            return Rectangle(width: data.width ?? 0.0)
        case .ring:
            return Ring(radius: data.radius ?? 0)
        default:
            return BaseControllable()
        }
    }
}

class BaseControllable: Codable {
    
    func toBaseData() -> ShapeData {
        return ShapeData(type: getType(), data: self.createStruct()!)
    }
    
    func getType() -> BaseType {
        return .unknown
    }
    
    func createStruct() -> ControlableStruct? {
        if let ring = self as? Ring {
            return ControlableStruct(radius: ring.radius)
        }
        if let rect = self as? Rectangle {
            return ControlableStruct(width: rect.width)
        }
        
        return nil
    }
}

class Rectangle: BaseControllable {
    
    var width: Float
    
    enum CodingKeys : String, CodingKey {
        case width
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        width = try values.decode(Float.self, forKey: .width)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(width, forKey: .width)
    }
    
    init(width: Float) {
        self.width = width
        super.init()
    }
    
    override func getType() -> BaseType {
        return .rectangle
    }
}

struct RectangleStruct: Codable {
    var width: Float
}

class Ring: BaseControllable {
    var radius: Int
    
    struct Data: Codable {
        var radius: Int
    }
    
    func toData() -> Data {
        return Data(radius: radius)
    }
    
    func fromData(_ data: Data) {
        self.radius = data.radius
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        fromData(try container.decode(Data.self))
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(toData())
    }
    
    init(radius: Int) {
        self.radius = radius
        super.init()
    }
    
    override func getType() -> BaseType {
        return .ring
    }
}

class SceneNodes: Codable {
    
    var shapes: [BaseControllable]
    
    init(shapes: [BaseControllable]) {
        self.shapes = shapes
    }
    
    enum CodingKeys : String, CodingKey {
        case shapes
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let animalData = try values.decode([ShapeData].self, forKey: .shapes)
        shapes = animalData.map{ return $0.convertToClass() }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let shapeData = shapes.map { return $0.toBaseData() }
        
        try container.encode(shapeData, forKey: .shapes)
    }
}
