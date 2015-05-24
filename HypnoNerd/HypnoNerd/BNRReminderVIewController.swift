//
//  BNRReminderVIewController.swift
//  HypnoNerd
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRReminderVIewController: UIViewController {
    @IBOutlet weak var datePicker:UIDatePicker?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "Reminder"
        var image = UIImage(named: "Time.png")
        self.tabBarItem.image = image
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addReminder( sender:UIDatePicker ){
        var date = self.datePicker!.date
        println("Setting a reminder for \(date)")
        
        var note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date;
        
        UIApplication.sharedApplication().scheduledLocalNotifications.append(note)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("BNRReminderViewController loaded its view")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker?.minimumDate = NSDate(timeIntervalSinceNow: 60)
        
    }
    
    
}
