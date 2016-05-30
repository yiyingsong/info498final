//
//  Alarmcell.swift
//  alarm-Caroline
//
//  Created by apple on 5/27/16.
//  Copyright © 2016 apple. All rights reserved.
//
import UIKit

class Alarmcell: UITableViewCell {
    
    @IBOutlet weak var o: UISwitch!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.o.addTarget(self, action: #selector(Alarmcell.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            title.textColor = UIColor(hue: 0.5833, saturation: 0.44, brightness: 0.36, alpha: 1.0)
            subtitle.textColor = UIColor(hue: 0.5833, saturation: 0.44, brightness: 0.36, alpha: 1.0)
        } else {
            title.textColor = UIColor.lightGrayColor()
            subtitle.textColor = UIColor.lightGrayColor()
        }
    }
    
    
}
