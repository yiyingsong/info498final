//
//  Alarm.swift
//  alarm-Caroline
//
//  Created by apple on 5/27/16.
//  Copyright © 2016 apple. All rights reserved.
//

import Foundation

class Alarm {
    internal var AlarmID: String
    internal var isActive: Bool
    internal var wakeup: NSDate
    
    /* CONSTRUCTORS */
    
    init () {
        self.AlarmID = NSUUID().UUIDString
        self.isActive = true
        self.wakeup = NSDate()
    }
    
    init (UUID: String, wakeTime : NSDate) {
        self.AlarmID = UUID
        self.isActive = true
        self.wakeup = wakeTime
    }
    
    init (copiedAlarm: Alarm) {
        self.AlarmID = copiedAlarm.AlarmID
        self.isActive = copiedAlarm.isActive
        self.wakeup = copiedAlarm.wakeup
    }
    
    /* METHODS */
    
    func copy() -> Alarm {
        return Alarm(copiedAlarm: self)
    }
    
    func turnOn () {
        self.isActive = true
    }
    
    func turnOff () {
        self.isActive = false
    }
    
    func getWakeupString () -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return dateFormatter.stringFromDate(self.wakeup)
    }
    
//    func calculateWakeup() -> NSDate {
//        let components: NSDateComponents = NSDateComponents()
//        let result = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.wakeup, options: NSCalendarOptions(rawValue: 0))
//        return result!
//    }
    
    /* ACCESS CONTROL METHODS */
    
    func setAlarmID (newID: String) {
        self.AlarmID = newID
    }
    
    
    func setWakeup (wakeup: NSDate) {
        self.wakeup = wakeup
    }
    
    /* SERIALIZATION */
    
    func toDictionary () -> NSDictionary {
        let dict: NSDictionary = [
            "AlarmID": self.AlarmID,
            "isActive": self.isActive,
            "wakeup": self.wakeup
        ]
        return dict
    }
    
    func fromDictionary (dict: NSDictionary) {
        self.AlarmID = dict.valueForKey("AlarmID") as! String
        self.isActive = dict.valueForKey("isActive") as! Bool
        self.wakeup = dict.valueForKey("wakeup") as! NSDate
    }
}