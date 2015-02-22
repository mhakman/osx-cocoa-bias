//
//  GenController.swift
//  Bias
//
//  Created by Mikael Hakman on 2015-02-19.
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

class GenController : NSObjectController {

    @IBOutlet var window : NSWindow!
    
    @IBOutlet var model : GenModel!
    
    lazy var openPanel = NSOpenPanel ()
    
    lazy var savePanel = NSSavePanel ()
    
    @IBAction func generateAction (sender : AnyObject) {
        
        self.model.generateOutput ()
    }
    
    @IBAction func browseOutputAction(sender: AnyObject) {
        
        self.setupFilePanel (self.savePanel)
        
        self.savePanel.allowedFileTypes = ["swift"]
        
        self.savePanel.canCreateDirectories = true
        
        self.savePanel.beginSheetModalForWindow (self.window, completionHandler : self.savePanelCompleted)
    }
    
    func savePanelCompleted (response : Int) -> Void {
        
        if response == NSFileHandlingPanelCancelButton {
            
            return
        }
        
        let path = self.getFilePathFromPanel (self.savePanel)
        
        if (path != nil) {
            
            self.model.outputPath = path
        }
    }
    
    @IBAction func browseInputAction (sender : AnyObject) {
        
        self.setupFilePanel (self.openPanel)
        
        self.openPanel.canChooseFiles = true
        
        self.openPanel.canChooseDirectories = false
        
        self.openPanel.allowsMultipleSelection = false

        self.openPanel.beginSheetModalForWindow (self.window, completionHandler : self.openPanelCompleted)
    }
    
    func openPanelCompleted (response : Int) -> Void {
        
        if response == NSFileHandlingPanelCancelButton {
            
            return
        }
        
        let path = self.getFilePathFromPanel (self.openPanel)
        
        if path != nil {
       
            self.model.inputPath = path
        }
    }
    
    func getFilePathFromPanel (panel : NSSavePanel) -> String! {
        
        let url : NSURL! = panel.URL
        
        if url == nil {
            
            return nil
        }
        
        let path : String! = url.path
        
        if path == nil {
            
            return nil
        }

        return path
    }
    
    func setupFilePanel (filePanel : NSSavePanel) {
        
        filePanel.showsHiddenFiles = true
        
        filePanel.extensionHidden = false
        
        filePanel.treatsFilePackagesAsDirectories = true
    }
}
