//
//  TransistorType.swift
//  Bias
//
//  Created by Mikael Hakman on 2015-02-21.
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class Transistor : NSObject {
    
    dynamic var type : String = ""
        
    dynamic var isat : Double = 1e-16
        
    dynamic var beta : Double = 100.0
    
    override init () {
        
        super.init ()
    }
    
    init (type : String, isat : Double, beta : Double) {
        
        self.type = type
        
        self.isat = isat
        
        self.beta = beta
    }
    
    class var typeList : [String] {
        
        get {
            
            var list = [String] ()
            
            for type in Transistors.keys {
                
                list.append (type)
            }
            
            list.sort ({$0 < $1})
            
            return list
        }
    }
    
    class func getTransistorType (type : String) -> Transistor? {
        
        return Transistors [type]
    }
}
