//
//  JsonParser.swift
//  JsonParserHelper
//
//  Created by Jabez on 15/5/4.
//  Copyright (c) 2015年 John. All rights reserved.
//

import Foundation


class JsonParser : NSObject {
    
    class func parserRootObject(root: NSObject) -> Void {
        if root.isKindOfClass(NSArray) {
            parserRootArray(root as! NSArray, superKey: "Root")
        } else if (root.isKindOfClass(NSDictionary)) {
            parserRootDictionary(root as! NSDictionary, superKey:"Root")
        } else {
            print("not good json");
        }
    }
    
    class func parserRootDictionary(root: NSDictionary, superKey: NSString?) {
        
        for (key, value) in root {
            
        }
    }
    
    class func parserRootArray(root: NSArray, superKey: NSString?) {
        
    }
    
    class func isNormalData(dict: NSDictionary) -> Bool {
        var isNormal = true;
        for value in dict.allValues {
            var data:NSObject = value as! NSObject;
            if data.isKindOfClass(NSArray) || data.isKindOfClass(NSDictionary) {
                isNormal = false;
            }
        }
        return isNormal;
    }
    
    class func isNormalArray(list: NSArray) -> Bool {
        var isNormal = true;
        for value in list {
            var data:NSObject = value as! NSObject;
            if data.isKindOfClass(NSArray) || data.isKindOfClass(NSDictionary) {
                isNormal = false;
            }
        }
        return isNormal;
    }
}