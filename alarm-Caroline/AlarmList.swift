//
//  AlarmList.swift
//  alarm-Caroline
//
//  Created by apple on 5/28/16.
//  Copyright © 2016 apple. All rights reserved.
//

import Foundation
import UIKit

class AlarmList {
    private let ALARMS_KEY = "alarmItems"
    
    /* SINGLETON CONSTRUCTOR */
    
    class var sharedInstance: AlarmList {
        struct Static {
            static let instance: AlarmList = AlarmList()
        }
        return Static.instance
    }
    
    func allAlarms () -> [Alarm] {
        let alarmDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ALARMS_KEY) ?? Dictionary()
        var alarmItems:[Alarm] = []
        
        for data in alarmDictionary.values {
            let dict = data as! NSDictionary
            let alarm = Alarm()
            alarm.fromDictionary(dict)
            alarmItems.append(alarm)
        }
        return alarmItems
    }
    
    func addAlarm (newAlarm: Alarm) {
        // Create persistent dictionary of data
        var alarmDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ALARMS_KEY) ?? Dictionary()
        
        // Copy alarm object into persistent data
        alarmDictionary[newAlarm.AlarmID] = newAlarm.toDictionary()
        
        // Save or overwrite data
        NSUserDefaults.standardUserDefaults().setObject(alarmDictionary, forKey: ALARMS_KEY)
        
        // Schedule notifications
        scheduleNotification(newAlarm)
    }
    
    func removeAlarm (alarmToRemove: Alarm) {
        // Remove alarm notifications
        cancelNotification(alarmToRemove)
        
        // Remove alarm from persistent data
        if var alarmDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ALARMS_KEY) {
            alarmDictionary.removeValueForKey(alarmToRemove.AlarmID as String)
            NSUserDefaults.standardUserDefaults().setObject(alarmDictionary, forKey: ALARMS_KEY)        }
    }
    
    func updateAlarm (alarmToUpdate: Alarm) {
        // Remove old alarm
        removeAlarm(alarmToUpdate)
        
        // Create new unique IDs
        let newUUID = NSUUID().UUIDString
        
        // Associate with the alarm by updating IDs
        alarmToUpdate.AlarmID = newUUID
        // Reschedule new alarm
        addAlarm(alarmToUpdate)
    }
    
    func scheduleNotification (alarm: Alarm) {
        let notification = UILocalNotification()
        notification.category = "ALARM_CATEGORY";
        notification.repeatInterval = NSCalendarUnit.Day

        notification.userInfo = ["AlarmID": alarm.AlarmID]
        notification.alertBody = "Time to wake up!"
        notification.fireDate = alarm.wakeup
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        // For debugging purposes
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        print("ALARM SCHEDULED FOR :", dateFormatter.stringFromDate(notification.fireDate!))
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
   //Jingwen: Notification
    /* 
 
 
 */
    
    func cancelNotification (alarm: Alarm) {
        let ID: String = alarm.AlarmID
        
        for event in UIApplication.sharedApplication().scheduledLocalNotifications! {
            let notification = event as UILocalNotification
            if (notification.userInfo!["AlarmID"] as! String == ID) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
    }
}