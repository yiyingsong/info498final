//
//  AddViewController.swift
//  alarm-Caroline
//
//  Created by apple on 5/28/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var alarm: Alarm = Alarm();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fix iOS 9 bug in mildy hacky way...
        datePicker.datePickerMode = .DateAndTime
        datePicker.datePickerMode = .Time
        
        // Data model
        datePicker.setDate(NSDate(), animated: true);
    }
    
    @IBAction func timeUpdate(sender: AnyObject) {
        updateTimeLabels(sender as! UIDatePicker)
    }
    
    func updateTimeLabels (sender: UIDatePicker) {
        alarm.wakeup = sender.date;
    }
    
}
