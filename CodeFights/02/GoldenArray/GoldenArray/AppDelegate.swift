//
//  AppDelegate.swift
//  GoldenArray
//
//  Created by David Szurma on 1/24/17.
//  Copyright © 2017 OTT-ONE Nyrt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func sum(currentIndex: Int, array: [Int], pastStates: [Int: Int]? = nil) -> Int {
        
        var newPastStates = [Int:Int]()
        
        if pastStates?[currentIndex] != nil { return pastStates![currentIndex]! }
        
        if currentIndex >= array.count { return 0 }
        
        let leftPartialSum = sum(currentIndex: currentIndex+2, array: array, pastStates: pastStates)
        let rightPartialSum = sum(currentIndex: currentIndex+3, array: array, pastStates: pastStates)
        let sumValue =  array[currentIndex] + max(leftPartialSum, rightPartialSum)
        
        newPastStates![currentIndex] = sumValue
        return sumValue
    }
    
    func robotkar(rogok: [Int]) -> Int {
        let res = sum(currentIndex: 0, array: rogok)
        let resNext = sum(currentIndex: 1, array: rogok)
        return max(res,resNext)
    }



}

