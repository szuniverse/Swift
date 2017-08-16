//
//  CircleViewModel.swift
//  RxSwiftExample
//
//  Created by David Szurma on 6/26/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import ChameleonFramework
import Foundation
import RxSwift
import RxCocoa

class CircleViewModel {
    
    var centerVariable = Variable<CGPoint?>(.zero) // Create one variable that will be changed and observed
    var backgroundColorObservable: Observable<UIColor>! // Create observable that will change backgroundColor based on center
    var cornerRadiusObservable: Observable<CGFloat>!
    
    init() {
        setup()
    }
    
    func setup() {
        // When we get new center, emit new UIColor
        backgroundColorObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else { return UIColor.flatten(.black)() }
                
                let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0 // We just manipulate red, but you can do w/e
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
        }
        
        cornerRadiusObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else {
                    return 0
                }
                let viewHalfHeight: CGFloat = 50
                let y = center.y - viewHalfHeight
                let height = UIScreen.main.bounds.height - 100
                var radius = y / height * viewHalfHeight
                
                radius = radius > viewHalfHeight ? viewHalfHeight : radius
                return radius
        }
    }
}
