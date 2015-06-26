//
//  OCHCreator.swift
//  JsonParserHelper
//
//  Created by Jabez on 15/5/4.
//  Copyright (c) 2015年 John. All rights reserved.
//

import Foundation

class OCHCreator: NSObject {
    var content: NSMutableString = "";
    var fileName: NSString;
    var fileFolder: NSString;
    
    init(fileName: NSString, fileFolder: NSString) {
        self.fileName = fileName;
        self.fileFolder = fileFolder;
        super.init()
        
        appendHeaderFile();
    }
    
    func appendHeaderFile() {
        content.appendString("#import <Foundation/Foundation.h>\n")
        content.appendFormat("@interface %@: NSObject  \n", fileName)
    }
    
    func appendProperty(paramType:NSString, paramName:NSString) {
        content.appendFormat("@property (nonatomic, strong) %@ *%@\n", paramType, paramName)
    }
    
    func appendInitMethod(paramType:NSString, paramName:NSString) {
        content.appendFormat("+ (instance)instanceWithData:(%@ *)%@;\n", paramType, paramName)
    }
    
    func finishAppend() {
        content.appendString("\n}\n @end\n\n")
    }
    
    func write() {
        if !NSFileManager.defaultManager().fileExistsAtPath(self.fileFolder as String) {
            NSFileManager.defaultManager().createDirectoryAtPath(fileFolder as String,
                withIntermediateDirectories: true, attributes: nil, error: nil);
        }
        
        var path = NSString(format: "%@/%@.h", fileFolder, fileName);
        content.writeToFile(path as String, atomically: true, encoding: NSUTF8StringEncoding, error: nil);
    }
    
//    func properNameWith(key: NSString) -> NSString {
//        var array
//    }
}
