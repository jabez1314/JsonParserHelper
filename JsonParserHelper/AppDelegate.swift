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



    func applicationDidFinishLaunching(aNotification: NSNotification) {

        var parser = SimpleJsonParser();
        var str = NSBundle.mainBundle().pathForResource("test", ofType: "json");
        parser.parsejson(str!);
//        var str = parser.propertyName("hello_hsss");
//        println("str: " + str);
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

