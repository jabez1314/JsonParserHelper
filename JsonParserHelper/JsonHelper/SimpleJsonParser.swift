//
//  SimpleJsonParser.swift
//  JsonParserHelper
//
//  Created by Jabez on 6/26/15.
//  Copyright (c) 2015 John. All rights reserved.
//

import Cocoa

class SimpleJsonParser: NSObject {

    var propertyList = NSMutableArray();
    var parseList = NSMutableArray();
    
    func parsejson(filePath: String) {
        var data = NSData(contentsOfFile: filePath);
        if (nil == data || data?.length == 0) {
            return
        }
        
        var obj = NSJSONSerialization .JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil);
        if nil == obj {
            return
        }
        
        var object: NSObject = obj as! NSObject;
        
        if object.isKindOfClass(NSDictionary) {
            parseDict(object as! NSDictionary);
        } else if object.isKindOfClass(NSArray) {
            parseArray(object as! NSArray);
        }
        
        printArray(propertyList);
        printArray(parseList);
    }
    
    func parseArray(array: NSArray) {
        
        for (var i = 0; i < array.count; i++) {
            var obj = array[i] as! NSObject;
            
            if obj.isKindOfClass(NSDictionary) {
                parseDict(obj as! NSDictionary);
            } else if obj.isKindOfClass(NSArray) {
                parseArray(obj as! NSArray)
            }
            
        }
    }
    
    func parseDict(dict: NSDictionary) {
        
        for (key, value) in dict {
            
            if (value.isKindOfClass(NSDictionary) || value.isKindOfClass(NSArray)) {
                continue;
            }
            parseString(key as! String)
        }

        
        
        for (key, value) in dict {
            
            if (!value.isKindOfClass(NSDictionary) && !value.isKindOfClass(NSArray)) {
                continue;
            }
            
            parseString(key as! String)
            
            if value.isKindOfClass(NSDictionary) {
                parseList.addObject("{\n");
                propertyList.addObject("{\n");
                parseDict(value as! NSDictionary);
                propertyList.addObject("}\n");
                parseList.addObject("}\n")
                
            } else if value.isKindOfClass(NSArray) {
                parseList.addObject("[\n");
                propertyList.addObject("[\n");
                
                parseArray(value as! NSArray)
                
                propertyList.addObject("]\n");
                parseList.addObject("]\n")
            }
            
        }
    }
    
    func parseString(str: String) {
        var name = propertyName(str)
        var property = "@property (strong, nonatomic) NSString *" + name  + ";"
        
        var sign = "song." + name + " = data[@\"" + str + "\"];";
        
        propertyList.addObject(property);
        parseList.addObject(sign);
    }
    
    func propertyName(name: String) -> String {
        var source = NSMutableString(string: name);
        
        
        if source.isEqualToString("id") {
            return "ID";
        }
        
        if source.isEqualToString("like") {
            return "isLike";
        }
        
        
        var range = source.rangeOfString("_");
        if range.location == 0 {
            return name;
        }
        
    
        var results = "";
        var meetSubLine = false;
        for str in name {
            
            var equal = Character("_");
            if (str == equal) {
                meetSubLine = true;
            } else {
                if meetSubLine == true {
                    meetSubLine = false;
                
                    var upper = String(str).uppercaseString;
                    results.extend(upper);
                } else {
                    results.append(str);
                }
            }
        }
        
        return results;
    }
    
    func printArray(array: NSArray) {
        for str in array {
            println(str);
        }
        
        println("\n\n------------------\n\n");
    }
}
