//
//  ViewController.swift
//  JsonParserHelper
//
//  Created by Jabez on 15/5/4.
//  Copyright (c) 2015年 John. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var parseButton: NSButton!
    @IBOutlet weak var sourceButton: NSButton!
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var leftInput: NSTextField!
    @IBOutlet weak var rightInput: NSTextField!
    
    var sourceString: String?
    var destString: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.textView.becomeFirstResponder();
    }
    
    @IBAction func tappedButton(sender: NSButton) {
        
        if (textView.string != destString) {
            sourceString = textView.string;
        }
        
        var left = self.leftInput.stringValue ?? self.leftInput.placeholderString;
        var right = self.rightInput.stringValue ?? self.rightInput.placeholderString;
        
        var parser = SimpleJsonParser(left: left!, right: right!);
        if textView.string != nil {
            var (error, value) = parser.parseJsonWithString(textView.string!)
            
            if (error == nil)  {
                destString = value;
                textView.string = destString;
            } else {
                var alert = NSAlert(error: error!)
                alert.runModal()
            }
            
        }
    }

    @IBAction func showSource(sender: NSButton) {
        textView.string = sourceString;
    }
}

