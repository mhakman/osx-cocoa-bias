//
//  GenTransistor.swift
//  Bias
//
//  Created by Mikael Hakman on 2015-02-21.
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class GenTransistor : NSObject {
    
    dynamic var type = ""
    
    dynamic var isat = 1e-16
    
    dynamic var beta = 100.0
    
    init (type : NSString, isat : Double, beta : Double) {
        
        super.init ()
        
        self.type = type
        
        self.isat = isat
        
        self.beta = beta
    }
}
