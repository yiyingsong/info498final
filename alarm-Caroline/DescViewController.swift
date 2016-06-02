//
//  DescViewController.swift
//  questionsForTikTok
//
//  Created by Jingwen Guo on 5/28/16.
//  Copyright © 2016 lazyHuskies. All rights reserved.
//

import UIKit
import AVFoundation

class DescViewController: UIViewController {

    
    @IBOutlet weak var reading: UILabel!
    
    var paragraph : String = ""
    var questionsForReading = [Question]()
    var transferData = [Question]()
    var sound : AVAudioPlayer!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reading.text = paragraph
        questionsForReading = transferData
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuestion" {
            let questionVC  = segue.destinationViewController as! QuestionViewController
            questionVC.transferQ = questionsForReading
            questionVC.sound = sound;
        }
    }
}
