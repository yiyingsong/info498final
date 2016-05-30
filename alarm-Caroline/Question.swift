//
//  Question.swift
//  questionsForTikTok
//
//  Created by Jingwen Guo on 5/28/16.
//  Copyright © 2016 lazyHuskies. All rights reserved.
//

import Foundation
class Question {
    init(questionText: String, correctAnswer: Int, answers: [String]){
        self.questionText = questionText
        self.correctAnswer = correctAnswer
        self.answers = answers
    }
    
    
    
    var questionText: String = ""
    //this is due the arrat is one position eariler with the actual answer
    var correctAnswer: Int = -1
    var answers = [String]()
    
}