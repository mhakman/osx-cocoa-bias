//
//  GenTextView.swift
//  Bias
//
//  Created by Mikael Hakman on 2015-02-20.
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class GenTextView : NSTextView {

    required init? (coder : NSCoder) {
        
        super.init (coder : coder)
        
        let font = self.font
        
        self.string = ""
        
        self.font = font!
    }
    
    override func drawRect (dirtyRect : NSRect) {
    
        super.drawRect (dirtyRect)
    }

    override func awakeFromNib () {
        
        super.awakeFromNib ()
        
        let contentSize : NSSize = self.enclosingScrollView!.contentSize
        
        self.minSize = NSSize (width : 0, height : 0)
        
        self.maxSize = NSSize (width : 1000000, height : 1000000)
                
        self.textContainer?.containerSize = NSSize (width : 1000000, height : 1000000)
        
        self.textContainer?.widthTracksTextView = false
    }

}
