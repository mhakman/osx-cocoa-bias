//
//  ValueFormatter.swift
//
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class ValueFormatter : NSNumberFormatter {

    override init () {
        
        super.init ()
        
        self.initialize ()
    }

    required init (coder: NSCoder) {
        
        super.init (coder : coder)
        
        self.initialize ()
    }
    
    func initialize () {
        
        self.usesSignificantDigits = true
        
        self.minimumSignificantDigits = 3
        
        self.maximumSignificantDigits = 3
    }
/*
    override func stringFromNumber (number : NSNumber) -> String? {
        
        let val : Double = number.doubleValue
        
        if val < 1e-6 || val >= 1e+7 {
            
            self.numberStyle = NSNumberFormatterStyle.ScientificStyle
            
        } else {
            
            self.numberStyle = NSNumberFormatterStyle.DecimalStyle
        }
        
        return super.stringFromNumber (number)
    }
    
    override class func localizedStringFromNumber (num : NSNumber, numberStyle : NSNumberFormatterStyle) -> String {
        
        let val : Double = num.doubleValue
        
        var style : NSNumberFormatterStyle = NSNumberFormatterStyle.NoStyle
        
        if val < 1e-6 || val >= 1e+7 {
            
            style = NSNumberFormatterStyle.ScientificStyle
            
        } else {
            
            style = NSNumberFormatterStyle.DecimalStyle
        }

        return super.localizedStringFromNumber (num, numberStyle: style)
    }
*/
    override func stringForObjectValue (object : AnyObject) -> String? {

        if object is NSNumber {
            
            let val : Double = (object as NSNumber).doubleValue
            
            if val < 1e-6 || val >= 1e+7 {
                
                self.numberStyle = NSNumberFormatterStyle.ScientificStyle
                
            } else {
                
                self.numberStyle = NSNumberFormatterStyle.DecimalStyle
            }
        }
        
        return super.stringForObjectValue (object)
    }
}
