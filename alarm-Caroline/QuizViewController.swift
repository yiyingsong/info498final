//
//  ViewController.swift
//  questionsForTikTok
//
//  Created by Jingwen Guo on 5/28/16.
//  Copyright © 2016 lazyHuskies. All rights reserved.
//

import AVFoundation

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var TopicArray = [Topic]()

    
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

    
    override func viewDidLoad() {
          super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        retrieveOffline()
        playBackgroundMusic("bell.mp3")
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //build the tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopicArray.count
    }

    //build the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomizeCell
        if(TopicArray.count != 0){
            cell.title.text = TopicArray[indexPath.row].title
        }else{
            cell.title.text = ""
        }
        return cell
    }
    
    
    //use the local JSON
    private func retrieveOffline() {
        if let path = NSBundle.mainBundle().pathForResource("question", ofType: "json"){
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let tpArray = (json as? NSArray){
                    for tp in tpArray{
                        let title = tp["title"] as! String
                        let descr = tp["desc"] as! String
                        let questionArray = tp["questions"] as! NSArray
                        var qArray = [Question]()
                        for q in questionArray {
                            let text = q["text"] as! String
                            let correctAnswer = q["answer"] as! NSInteger
                            let answersArray = q["answers"] as! NSArray
                            var AnswersArray = [String]()
                            for a in answersArray {
                                AnswersArray.append(a as! String)
                                print("\(a)")
                            }
                            
                            qArray.append(Question(questionText: text, correctAnswer: Int(correctAnswer), answers: AnswersArray))
                        }
                    let newTopic = Topic(title: title, description: descr,  questionList: qArray)
                    self.TopicArray.append(newTopic)
                    }
                }
            } catch let error as NSError {
                print("Error with Json: \(error)")
            }
        } else {
            print("Invalid filename/path.")
        }
        self.tableView.reloadData()
    }
    
    // use segue tafser data between different view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showReading" {
            let readingVC  = segue.destinationViewController as! DescViewController
            let myindexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let rowSelected = myindexPath.row
            
            readingVC.paragraph = TopicArray[rowSelected].description
            readingVC.transferData = TopicArray[rowSelected].questionList
            readingVC.sound = backgroundMusicPlayer;
        }
    }
    


}
