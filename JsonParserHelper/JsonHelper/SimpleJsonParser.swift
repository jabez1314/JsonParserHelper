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
    
    var left: String;
    var right: String;
    
    init(left: String, right: String) {
        self.left = left;
        self.right = right;
        super.init();
    }
    
    func parsejson(filePath: String) {
        var data = NSData(contentsOfFile: filePath);
        if (nil == data || data?.length == 0) {
            return
        }
        
        var obj: AnyObject? = NSJSONSerialization .JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil);
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
    
    func parseJsongWithString(source: String, left: String, right: String) -> (NSError?, String) {
        
        assert(source.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0, "source ok");
        assert(left.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0, "left ok");
        assert(right.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0, "right ok");
        
        self.left = left;
        self.right = right;
        
        return parseJsonWithString(source);
    }
    
    func parseJsonWithString(source: String) -> (NSError?, String) {
        
        assert(source.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0, "source ok");
        
        var error = NSError(domain: "ba json data", code: -1, userInfo: nil);
        var data = source.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true);
        if (nil == data || data?.length == 0) {
            return (error, "bad json data")
        }
        
        var obj: AnyObject? = NSJSONSerialization .JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil);
        if nil == obj {
            return (error, "bad json data")
        }
        
        var object: NSObject = obj as! NSObject;
        
        if object.isKindOfClass(NSDictionary) {
            parseDict(object as! NSDictionary);
        } else if object.isKindOfClass(NSArray) {
            parseArray(object as! NSArray);
        }
        
        var results = "";
        results += stringFromArray(propertyList);
        results += stringFromArray(parseList);
        
        return (nil, results)
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
        
        var sign = self.left +  "." + name + spaceStringFromName(name) + " = " + self.right + "[@\"" + str + "\"];";
        
        propertyList.addObject(property);
        parseList.addObject(sign);
    }
    
    func spaceStringFromName(name: String) -> String {
        var len = (left + "." + name).lengthOfBytesUsingEncoding(NSUTF8StringEncoding);
    
        var count = len / 7;
        if len % 7 == 0  {
            count -= 1;
        }
        
        len = 4 - count;
        var result = "";
        for (var i = 0; i < len; i++) {
            result += "\t"
        }
        return result;
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
    
    func stringFromArray(array: NSArray) -> String {
        
        var results = "";
        
        for str in array {
            results += str as! String;
            results += "\n"
        }
        
        results += "\n\n---------------\n\n";
        
        return results;
    }
}
