//
//  BNRDrawViewController.swift
//  TouchTracker
//
//  Created by sid on 5/27/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRDrawViewController: UIViewController {
   
    override func loadView() {
        self.view = BNRDrawView(frame:CGRectZero)
    }
    
}
