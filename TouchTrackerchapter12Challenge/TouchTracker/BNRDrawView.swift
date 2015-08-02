//
//  BNRDrawView.swift
//  TouchTracker
//
//  Created by sid on 5/27/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRDrawView: UIView {
    var linesInProgress:[NSValue:BNRLine]!
    var finishedLines:[BNRLine]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.finishedLines = [BNRLine]()
        self.linesInProgress = [NSValue:BNRLine]()
        self.backgroundColor = UIColor.grayColor()
        self.multipleTouchEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func strokeLine(line:BNRLine){
        var bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().set()
        for line in self.finishedLines {
            self.strokeLine(line as BNRLine)
        }
        
        UIColor.redColor().set()
        
        for line in self.linesInProgress{
            self.strokeLine(line.1)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        
        for touch in touches as! Set<UITouch> {
            var location = touch.locationInView(self)
            var line = BNRLine()
            line.begin = location
            line.end = location
            var key = NSValue(nonretainedObject: touch)
            self.linesInProgress[key] = line
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        
        for touch in touches as! Set<UITouch> {
            var key = NSValue(nonretainedObject: touch)
            var line = self.linesInProgress[key]
            line?.end = touch.locationInView(self)
        }
        self.setNeedsDisplay()
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        for touch in touches as! Set<UITouch>{
            let key = NSValue(nonretainedObject: touch)
            var line = self.linesInProgress[key]
            self.finishedLines.append(line!)
            self.linesInProgress.removeValueForKey(key)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        println(__FUNCTION__)
        
        for touch in touches as! Set<UITouch>{
            var key = NSValue(nonretainedObject: touch)
            self.linesInProgress.removeValueForKey(key)
        }
    }
}
