//
//  BNRHypnosisView.swift
//  BNRHypnosister
//
//  Created by sid on 5/23/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRHypnosisView: UIView {
    var circleColor:UIColor = UIColor.lightGrayColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.circleColor = UIColor.lightGrayColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentCircleColor(color:UIColor){
        self.circleColor = color
        self.setNeedsDisplay()
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        var bounds:CGRect = self.bounds
        var center = CGPoint()
        center.x = (bounds.origin.x) + (bounds.size.width / 2.0)
        center.y = (bounds.origin.y) + (bounds.size.height / 2.0)
        
        var maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0
        
        var path = UIBezierPath()
        
        for(var currentRadius = maxRadius;currentRadius > 0; currentRadius -= 20){
            path.moveToPoint( CGPointMake(center.x + currentRadius , center.y))
            
            path.addArcWithCenter(center, radius: currentRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI * 2.0) , clockwise: true)
            
        }
        
        //configure line width to 10 points
        path.lineWidth = 10
        self.circleColor.setStroke()
        path.stroke()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Touched \(self)")
        //changeColor()
    }
   
    
    func changeToColor(color:UIColor){
        setCurrentCircleColor(color)
    }
    
    
    func changeColor(){
        var red = (CGFloat(rand()) % 100 ) / 100.0;
        var green = (CGFloat(rand()) % 100 ) / 100.0;
        var blue = (CGFloat(rand()) % 100 ) / 100.0;
        
        var randomColor = UIColor(red: red, green: green, blue: blue, alpha: CGFloat(1.0))
        
        //self.circleColor = randomColor
        setCurrentCircleColor(randomColor)
    }

}
