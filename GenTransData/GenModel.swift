//
//  GenModel.swift
//  Bias
//
//  Created by Mikael Hakman on 2015-02-19.
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class GenModel : NSObject {
    
    var defaultInputPath = "/Applications/LTspice.app/Contents/lib/cmp/standard.bjt"
    
    dynamic var inputPath : String = "" {
        
        didSet {
            
            if self.inputReadable {
                
                self.readInput ()
            }
            
            self.checkCanGenerate ()
        }
    }
    
    dynamic var outputPath : String = "" {
        
        didSet {
            
            self.checkCanGenerate ()
        }
    }
    
    dynamic var canGenerate = false
    
    dynamic var inputText : String = ""
    
    dynamic var transistors = [GenTransistor] ()
    
    dynamic var code = ""
    
    override init () {
        
        super.init ()
    }
    
    override func awakeFromNib () {
    
        super.awakeFromNib ()
        
        self.setDefaults ()
    }
    
    func setDefaults () {
        
        let fm = NSFileManager.defaultManager ()
        
        let defaultInputIsReadable = fm.isReadableFileAtPath (self.defaultInputPath)
        
        if defaultInputIsReadable {
            
            self.inputPath = self.defaultInputPath
        }
    }
    
    var inputReadable : Bool {
        
        let fm = NSFileManager.defaultManager ()
        
        return fm.isReadableFileAtPath (self.inputPath)
    }
    
    func checkCanGenerate () {
        
        if !self.inputReadable {
            
            self.canGenerate = false
            
            return
        }
        
        let fm = NSFileManager.defaultManager ()
        
        if self.outputPath == "" {
            
            self.canGenerate = false
            
            return
        }
        
        if !fm.fileExistsAtPath (self.outputPath) {
            
            self.canGenerate = true
            
            return
        }
        
        if !fm.isWritableFileAtPath (self.outputPath) {
            
            self.canGenerate = false
            
            return
        }
        
        self.canGenerate = true
    }
    
    func readInput () {
        
        self.inputText = NSString (contentsOfFile : self.inputPath, encoding : NSMacOSRomanStringEncoding, error : nil)!
    }
    
    func writeOutput () {
        
        self.code.writeToFile (self.outputPath, atomically : false, encoding : NSUTF8StringEncoding, error : nil)
    }
    
    func generateOutput () {
        
        self.scanInput ()
        
        self.generateCode ()
    }
    
    func generateCode () {
        
        self.code = ""
        
        self.generateProlog ()
        
        self.generateData ()
        
        self.generateEpilog ()
        
        self.writeOutput ()
    }
    
    func generateProlog () {
        
        self.code = self.code + "let Transistors : [String : Transistor] = [\n"
    }
    
    func generateData () {
        
        for trans in self.transistors {
            
            self.code = self.code + "\t\"\(trans.type)\" \t: "
            
            self.code = self.code + "Transistor (type : \"\(trans.type)\""
            
            self.code = self.code + "\t, isat : \(trans.isat)"

            self.code = self.code + "\t, beta : \(trans.beta))"
            
            if trans != self.transistors.last {
                
                self.code = self.code + ","
            }
            
            self.code = self.code + "\n"
        }
     }
    
    func generateEpilog () {
        
        self.code = self.code + "]\n"
    }
    
    func scanInput () {
        
        self.transistors = [GenTransistor] ()
        
        self.transistors.append (GenTransistor (type : "      ", isat : 1e-16, beta : 100.0))
        
        let lines = self.inputText.componentsSeparatedByString ("\n")
        
        var transLine = ""
        
        for line in lines {
            
            if line.hasPrefix (".") {
                
                if transLine != "" {
                    
                    self.scanLine (transLine)
                    
                    transLine = ""
                }
            }
            
            if line.hasPrefix (".") || line.hasPrefix ("+") {
                
                if line.hasPrefix("+") {
                    
                    transLine = transLine +  " " + (line as NSString).substringFromIndex (1)
                
                } else {
                
                    transLine += line
                }
            }
        }
    }
    
    func scanLine (transLine : String) {
        
        let words = transLine.componentsSeparatedByString (" ")
        
        let type = words[1]
        
        var isat = 1e-16
        
        var beta = 100.0
        
        for word in words {
            
            var item : NSString = word as NSString
            
            if item.hasPrefix ("NPN(") || item.hasPrefix ("PNP(") {
                
                item = item.substringFromIndex (4)
            }
            
            if item.hasSuffix (")") {
                
                item = item.substringToIndex (item.length - 1)
            }
            
            if item.hasPrefix ("IS=") {
                
                isat = (item.substringFromIndex (3) as NSString).doubleValue
                
                if item.hasSuffix ("f") {
                    
                    isat = isat * 1e-15
                }
                
            } else if item.hasPrefix ("BF=") {
                
                beta = (item.substringFromIndex (3) as NSString).doubleValue
            }
        }
        
        self.transistors.append (GenTransistor (type : type, isat : isat, beta : beta))
    }
}
