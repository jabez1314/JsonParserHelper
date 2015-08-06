//
//  AppDelegate.swift
//  JsonParserHelper
//
//  Created by Jabez on 15/5/4.
//  Copyright (c) 2015年 John. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    @IBAction func tappedNew(sender: NSMenuItem) {
        
    }


    func applicationDidFinishLaunching(aNotification: NSNotification) {

//        var parser = SimpleJsonParser();
//        var str = NSBundle.mainBundle().pathForResource("test", ofType: "json");
//        parser.parsejson(str!);
        
        
//        var str = parser.propertyName("hello_hsss");
//        println("str: " + str);
    }
    
    func applicationDidBecomeActive(notification: NSNotification) {
        
        if let win: NSWindow = NSApplication.sharedApplication().windows.first as? NSWindow {
            
//            win.becomeKeyWindow();
            if win.visible {
                return;
            }
//            win.becomeKeyWindow();
            win.level = 20;
            
        } else {
            
        }
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

