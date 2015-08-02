//
//  ViewController.swift
//  HypnoNerd
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRHypnosisViewController: UIViewController, UITextFieldDelegate {
    
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
        
        var textFieldRect = CGRectMake(20, 100, bounds.size.width - 40.0, 30)
        var textField = UITextField(frame: textFieldRect)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder = "Hypnotize me"
        textField.returnKeyType = UIReturnKeyType.Done
        textField.delegate = self
        backgroundView.addSubview(textField)
        
        
        var items = ["Red","Blue","Green"]
        var segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRectMake(10, 40,bounds.size.width - 20.0 , 20)
        segmentedControl.addTarget(self, action: Selector("changeColorSegmented:"), forControlEvents: UIControlEvents.AllEvents)
        segmentedControl.selectedSegmentIndex = 0
        
        self.view.addSubview(segmentedControl)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.drawHypnoticMessage(textField.text)
        textField.text = ""
        textField.resignFirstResponder()
        return true
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
    
    func drawHypnoticMessage(message:String){
        
        for(var i = 0; i < 20; i++){
            var messageLabel = UILabel()
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.textColor = UIColor.whiteColor()
            messageLabel.text = message
            messageLabel.sizeToFit()
            
            var width = self.view.bounds.size.width - messageLabel.bounds.size.width
            var x = CGFloat(arc4random()) % width
            
            var height = self.view.bounds.size.height - messageLabel.bounds.size.height
            var y = CGFloat(arc4random()) % height
            
            var frame = messageLabel.frame
            frame.origin = CGPointMake(x, y)
            messageLabel.frame = frame
            
            self.view.addSubview(messageLabel)
            
            messageLabel.alpha = 0.0
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                messageLabel.alpha = 1.0
                }, completion: nil)
            
            
            UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.allZeros, animations: {
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.8, animations: {
                    messageLabel.center = self.view.center
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2, animations: {
                    var x = CGFloat(rand()) % width
                    var y = CGFloat(rand()) % height
                    messageLabel.center = CGPointMake(x, y)
                })
                }, completion: { finished in
                    println("Animation finished")
                })
            
            
            
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
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

