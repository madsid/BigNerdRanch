//
//  ViewController.swift
//  HypnoNerd
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRHypnosisViewController: UIViewController {
    
    var backgroundView = BNRHypnosisView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "Hypnotize"
        var image = UIImage(named: "Hypno.png")
        self.tabBarItem.image = image
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        var frame = UIScreen.mainScreen().bounds
        var bounds = UIScreen.mainScreen().bounds
        self.backgroundView = BNRHypnosisView(frame: frame)
        backgroundView.changeToColor(UIColor.redColor())
        self.view = backgroundView
        
        
        var items = ["Red","Blue","Green"]
        var segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRectMake(10, 40,bounds.size.width - 20.0 , 20)
        segmentedControl.addTarget(self, action: Selector("changeColorSegmented:"), forControlEvents: UIControlEvents.AllEvents)
        segmentedControl.selectedSegmentIndex = 0
        
        self.view.addSubview(segmentedControl)
    }
    
    func changeColorSegmented(segment:UISegmentedControl){
        if(segment.selectedSegmentIndex == 0){
            backgroundView.changeToColor(UIColor.redColor())
        }
        else if(segment.selectedSegmentIndex == 1){
            backgroundView.changeToColor(UIColor.blueColor())
        }
        else if(segment.selectedSegmentIndex == 2){
            backgroundView.changeToColor(UIColor.greenColor())
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("BNRHypnosisViewController loaded its view")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

