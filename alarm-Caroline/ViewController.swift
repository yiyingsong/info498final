//
//  ViewController.swift
//  alarm-Caroline
//
//  Created by apple on 5/27/16.
//  Copyright © 2016 apple. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var alarmList : [Alarm] = [Alarm(UUID: "zqazqaz", wakeTime: NSDate()), Alarm(UUID: "shshshs", wakeTime: NSDate()), Alarm(UUID: "aaahhh", wakeTime: NSDate())];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmList = AlarmList.sharedInstance.allAlarms();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        // Check if empty
//        noDataLabel.text = "No scheduled alarms"
//        noDataLabel.font = UIFont(name: "Lato", size: 20)
//        noDataLabel.textAlignment = NSTextAlignment.Center
//        noDataLabel.textColor = UIColor(hue: 0.5833, saturation: 0.44, brightness: 0.36, alpha: 1.0)
//        noDataLabel.alpha = 0.0
//        self.tableView.backgroundView = noDataLabel
//        checkScheduledAlarms()
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        // alarmList[0] = Alarm(UUID: "wake", wakeTime: NSDate());
        // self.view.addSubview(self.tableView);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Alarmcell")! as! Alarmcell
        //print(tableViewData)
        let wakeup = alarmList[indexPath.row].getWakeupString();
        cell.title.text! = wakeup;
        print(wakeup);
        cell.subtitle.text! = wakeup;
        cell.o.tag = indexPath.row;
        cell.o.addTarget(self, action: #selector(AlarmViewController.toggleAlarm(_:)), forControlEvents: UIControlEvents.ValueChanged)
        return cell
    }
    
    // to let AlarmList keep track of what alarms should ring
    func toggleAlarm (switchState: UISwitch) {
        let index = switchState.tag
        print(index);
        if switchState.on {
            alarmList[index].turnOn()
            AlarmList.sharedInstance.scheduleNotification(alarmList[index])
        } else {
            alarmList[index].turnOff()
            AlarmList.sharedInstance.cancelNotification(alarmList[index])
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            AlarmList.sharedInstance.removeAlarm(alarmList[indexPath.row]) // remove from persistent data
            alarmList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // Update tags for alarm state
            var t = 0
            for cell in tableView.visibleCells as! [Alarmcell] {
                cell.o.tag = t++
            }
            
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.editing == true) {
            performSegueWithIdentifier("editAlarm", sender: self)
        }
    }
    
    /* NAVIGATION */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editAlarm" || segue.identifier == "addAlarm") {
            let navVC = segue.destinationViewController as! UINavigationController
            let addAlarm = navVC.viewControllers.first as! AddViewController
            
            if (segue.identifier == "editAlarm") {
                let indexPath = self.tableView.indexPathForSelectedRow!
                addAlarm.alarm = alarmList[indexPath.row].copy()
                //addAlarm.title = "Edit Alarm"
            } else {
                //addAlarm.title = "Add Alarm"
            }
        }
    }

    
    // adding new alarms works properly
    @IBAction func saveAlarm (segue:UIStoryboardSegue) {
        let detailTVC = segue.sourceViewController as! AddViewController
        let newAlarm = Alarm(UUID: detailTVC.alarm.AlarmID, wakeTime: detailTVC.alarm.wakeup);
        
        if (self.tableView.editing == false) {
            let indexPath = NSIndexPath(forRow: alarmList.count, inSection: 0)
            alarmList.append(newAlarm)
            AlarmList.sharedInstance.addAlarm(newAlarm)
            
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        } else {
            let indexPath = self.tableView.indexPathForSelectedRow!
            self.alarmList[indexPath.row] = detailTVC.alarm.copy()
            AlarmList.sharedInstance.updateAlarm(self.alarmList[indexPath.row])
            
            self.tableView.beginUpdates()
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        }
    }
    
    @IBAction func cancelAlarm (segue:UIStoryboardSegue) {
        // Do nothing!
    }
    
   //Jinwgen Notification
//    
//     @IBAction func PushNotification(sender: AnyObject) {
//        var AlertView = UIAlertController(title: "Alarm", message: "Press to turn off" , preferredStyle: UIAlertControllerStyle.Alert )
//        AlertView.addAction(UIAlertAction(title:"Go", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(AlertView, animated:true, completion:nil)
//        
//     
//     }
 
}