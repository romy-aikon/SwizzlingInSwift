//
//  main.swift
//  SwizzlingInSwift
//
//  Created by Umberto Raimondi on 22/10/15.
//  Copyright © 2015 Umberto Raimondi. All rights reserved.
//

import Foundation


class TestSwizzling : NSObject {
    dynamic func methodOne()->Int{
        return 1
    }
}


extension TestSwizzling {
    
    //In Objective-C you'd perform the swizzling in load() , but this method is not permitted in Swift
    override class func initialize()
    {
        let _: () = {
            let originalSelector = #selector(TestSwizzling.methodOne)
            let swizzledSelector = #selector(TestSwizzling.methodTwo)
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }()
    }
    
    func methodTwo()->Int{
        // It will not be a recursive call anymore after the swizzling
        return methodTwo()+1
    }
}

var c = TestSwizzling()
print(c.methodOne())
print(c.methodTwo())


