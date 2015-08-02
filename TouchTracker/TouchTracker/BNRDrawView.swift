//
//  BNRDrawView.swift
//  TouchTracker
//
//  Created by sid on 5/27/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRDrawView: UIView, UIGestureRecognizerDelegate {
    var linesInProgress:[NSValue:BNRLine]!
    var finishedLines:[BNRLine]!
    weak var selectedLine:BNRLine!
    var moveRecognizer:UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.finishedLines = [BNRLine]()
        self.linesInProgress = [NSValue:BNRLine]()
        self.backgroundColor = UIColor.grayColor()
        self.multipleTouchEnabled = true
        
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("doubleTap:"))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        self.addGestureRecognizer(doubleTapRecognizer)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        self.addGestureRecognizer(tapRecognizer)
        
        var pressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("longPress:"))
        self.addGestureRecognizer(pressRecognizer)
        
        self.moveRecognizer = UIPanGestureRecognizer(target: self, action: Selector("moveLine:"))
        self.moveRecognizer.delegate = self
        self.moveRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(moveRecognizer)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doubleTap(gesture: UIGestureRecognizer){
        println("Recognized Double Tap")
        self.linesInProgress.removeAll(keepCapacity: true)
        self.finishedLines.removeAll(keepCapacity: true)
        self.setNeedsDisplay()
    }
    
    func tap(gesture: UIGestureRecognizer){
        println("Recognized Tap")
        var point = gesture.locationInView(self)
        self.selectedLine = self.lineAtPoint(point)
        
        if(self.selectedLine != nil){
            self.becomeFirstResponder()
            
            var menu = UIMenuController.sharedMenuController()
            var deleteItem = UIMenuItem(title: "Delete", action: Selector("deleteLine:"))
            menu.menuItems = [deleteItem]
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        }
        else{
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        
        self.setNeedsDisplay()
    }
    
    func longPress(gesture: UIGestureRecognizer){
        if(gesture.state == UIGestureRecognizerState.Began){
            var point = gesture.locationInView(self)
            self.selectedLine = self.lineAtPoint(point)
            
            if(self.selectedLine != nil){
                self.linesInProgress.removeAll(keepCapacity: true)
            }
        }
        else if(gesture.state == UIGestureRecognizerState.Ended ){
            self.selectedLine = nil
        }
        self.setNeedsDisplay()
    }
    
    func deleteLine(sender:AnyObject){
        var index = find(finishedLines, self.selectedLine)
        finishedLines.removeAtIndex(index!)
        self.selectedLine = nil
        setNeedsDisplay()
    }
    
    func strokeLine(line:BNRLine){
        var bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    }
    
    func moveLine(gesture: UIPanGestureRecognizer ){
        if(self.selectedLine == nil){
            return
        }
        
        if(gesture.state == UIGestureRecognizerState.Changed){
            var translation = gesture.translationInView(self)
            
            var begin = self.selectedLine.begin
            var end = self.selectedLine.end
            
            begin.x += translation.x
            begin.y += translation.y
            end.x += translation.x
            end.y += translation.y
            
            self.selectedLine.begin = begin
            self.selectedLine.end = end
            self.setNeedsDisplay()
            gesture.setTranslation(CGPointZero, inView: self)
        }
        
    }
    
    func lineAtPoint(point:CGPoint) -> BNRLine? {
        for line in self.finishedLines{
            var start = line.begin
            var end = line.end
            
            for(var t = 0.0; t < 1.0; t+=0.05){
                var x = CGFloat(Double(start.x) + t * Double((end.x - start.x)))
                var y = CGFloat(Double(start.y) + t * Double((end.y - start.y)))
                
                if hypot(x - point.x , y - point.y) < 20.0 {
                    return line
                }
            }
        }
        return nil
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if(gestureRecognizer == self.moveRecognizer){
            return true
        }
        return false
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
        
        if(self.selectedLine != nil){
            UIColor.greenColor().set()
            self.strokeLine(self.selectedLine)
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
