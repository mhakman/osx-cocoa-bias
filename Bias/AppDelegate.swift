//
//  AppDelegate.swift
//
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate : NSObject, NSApplicationDelegate {

    @IBOutlet weak var window : NSWindow!


    func applicationDidFinishLaunching (notification : NSNotification) {
        
        // Insert code here to initialize your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (theApplication : NSApplication) -> Bool {
        
        return true
    }

    func applicationWillTerminate (notification : NSNotification) {
        
        // Insert code here to tear down your application
    }


}

