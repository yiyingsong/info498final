//
//  ViewController.swift
//  typeChallenge
//
//  Created by apple on 5/30/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class TypeViewController: UIViewController {

    @IBOutlet weak var randomText: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        text.text = "Please type the exact same thing!"
        self.randomText.text = randomText(40, justLowerCase: false)
        
    }
    
    func randomText(length: Int, justLowerCase: Bool = false) -> String {
        var text = ""
        for _ in 1...length {
            var decValue = 0  // ascii decimal value of a character
            var charType = 3  // default is lowercase
            if justLowerCase == false {
                // randomize the character type
                charType =  Int(arc4random_uniform(4))
            }
            switch charType {
            case 1:  // digit: random Int between 48 and 57
                decValue = Int(arc4random_uniform(10)) + 48
            case 2:  // uppercase letter
                decValue = Int(arc4random_uniform(26)) + 65
            case 3:  // lowercase letter
                decValue = Int(arc4random_uniform(26)) + 97
            default:  // space character
                decValue = 32
            }
            // get ASCII character from random decimal value
            let char = String(UnicodeScalar(decValue))
            text = text + char
            // remove double spaces
            text = text.stringByReplacingOccurrencesOfString("  ", withString: " ")
        }
        print(text)
        print(text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        return text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }

    @IBAction func donePressed(sender: AnyObject) {
        if (userInput.text!.isEqual(randomText.text)){
            result.text = "Well done!"
        } else {
            result.text = "WROOOOONG!"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

