//
//  Issue.swift
//  RxSwiftExample
//
//  Created by David Szurma on 6/27/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import Foundation

import Mapper

struct Issue: Mappable {
    
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
