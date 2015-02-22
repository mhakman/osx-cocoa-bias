//
//  AppDelegate.swift
//  GenTransType
//
//  Created by Mikael Hakman on 2015-02-19.
//  Copyright (c) 2015 Mikael Hakman. All rights reserved.
//

import Cocoa

@NSApplicationMain

class AppDelegate : NSObject, NSApplicationDelegate {

    @IBOutlet weak var window : NSWindow!


    func applicationDidFinishLaunching (notification : NSNotification) {
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (theApplication : NSApplication) -> Bool {
        
        return true
    }

    func applicationWillTerminate (notification : NSNotification) {
       
    }


}

