//
//  topic.swift
//  questionsForTikTok
//
//  Created by Jingwen Guo on 5/28/16.
//  Copyright © 2016 lazyHuskies. All rights reserved.
//
import Foundation
class Topic {
    init(title: String, description: String, questionList:[Question]) {
        self.title = title
        self.description = description
        self.questionList = questionList
        
    }
    var title: String = ""
    var description: String = ""
    var questionList:[Question] = [Question]()
}