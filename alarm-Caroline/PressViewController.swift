//
//  ViewController.swift
//  finalProject
//
//  Created by apple on 5/30/16.
//  Copyright © 2016 Sophie. All rights reserved.
//

import UIKit

class PressViewController: UIViewController {

    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var button: UIButton!
    var random : Int = 0
    var pressed : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        random = Int(arc4random_uniform(20)) + 40
        text.text = "Please press the button for \(random) times!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        pressed = pressed + 1
        text.text = "Please press the button for \(random - pressed) times!"
        if (pressed == random) {
            button.enabled = false
            self.view.backgroundColor = UIColor.greenColor()
        } else {
            self.view.backgroundColor = UIColor.redColor()
        }
    }

}

