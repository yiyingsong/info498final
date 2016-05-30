//
//  QuestionViewController.swift
//  questionsForTikTok
//
//  Created by Jingwen Guo on 5/28/16.
//  Copyright © 2016 lazyHuskies. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var questions : [Question] = []
    var transferQ : [Question] = []
    var qNum = 0
       
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    var answerNum = Int()
    var TheFirstQuestion = true
  
    @IBOutlet weak var indicator: UILabel!
    var totalRight = 0
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        questions = transferQ
        Hide()
        RandomQuestion()
    }
    
    func RandomQuestion() {
        var total = questions.count
        print(total)
        print(questions);
        var randomNum = arc4random_uniform(UInt32(total))
        switch(randomNum){
        case 0: questionLabel.text = questions[0].questionText
                for i in 0..<buttons.count{
                    buttons[i].setTitle(questions[0].answers[i], forState: UIControlState.Normal)
                }
                answerNum = questions[0].correctAnswer - 1
        case 1: questionLabel.text = questions[1].questionText
                for i in 0..<buttons.count{
                    buttons[i].setTitle(questions[1].answers[i], forState: UIControlState.Normal)
                }
                answerNum = questions[1].correctAnswer - 1
        case 2: questionLabel.text = questions[2].questionText
                for i in 0..<buttons.count{
                    buttons[i].setTitle(questions[2].answers[i], forState: UIControlState.Normal)
                }
                answerNum = questions[2].correctAnswer - 1
        case 3: questionLabel.text = questions[3].questionText
        for i in 0..<buttons.count{
            buttons[i].setTitle(questions[3].answers[i], forState: UIControlState.Normal)
        }
        answerNum = questions[3].correctAnswer - 1

        default:break
            }

    }
    
    
    @IBAction func Button1Action(sender: AnyObject) {
        unhide()
        if answerNum == 0 {
            indicator.text = "You got right!"
            totalRight = totalRight + 1
            resultLabel.text = "total right questions: " + "\(totalRight)"
            indicator.textColor = UIColor.greenColor()
        } else{
            indicator.text = "You got wrong!"
            indicator.textColor = UIColor.redColor()

        }
    }
  
    @IBAction func Button2Action(sender: AnyObject) {
        unhide()
        if answerNum == 1 {
            indicator.text = "You got right!"
            totalRight = totalRight + 1
            resultLabel.text = "total right questions: " + "\(totalRight)"

            indicator.textColor = UIColor.greenColor()
        } else{
            indicator.text = "You got wrong!"
            indicator.textColor = UIColor.redColor()
            
        }    }
    
    
    @IBAction func Button3Action(sender: AnyObject) {
        unhide()
        if answerNum == 2 {
            indicator.text = "You got right!"
            totalRight = totalRight + 1
            resultLabel.text = "total right questions: " + "\(totalRight)"

            indicator.textColor = UIColor.greenColor()
        } else{
            indicator.text = "You got wrong!"
            indicator.textColor = UIColor.redColor()
            
        }
    }
    
    @IBAction func nextQuestion(sender: AnyObject) {
        RandomQuestion()
    }
   
    
    func Hide() {
        indicator.hidden = true
    }
    
    func unhide() {
        indicator.hidden = false
    }
    
    func stopAlarm(){
        if totalRight >= 2{
            resultLabel.text = "Congratulation!"
            //alarmstop
        }
    }
}
