//
//  BNRItem.swift
//  BNRHomepwner
//
//  Created by sid on 5/31/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BNRItem: NSManagedObject {

    @NSManaged var itemName: String
    @NSManaged var serialNumber: String
    @NSManaged var valueInDollars: Int
    @NSManaged var dateCreated: NSDate
    @NSManaged var itemKey: String
    @NSManaged var thumbnail: UIImage
    @NSManaged var orderingValue: Double
    @NSManaged var assetType: NSManagedObject
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        dateCreated = NSDate()
        
        var uuid = NSUUID()
        var key = uuid.UUIDString
        itemKey = key
    }
    
    
    
    func setThumbnailFromImage(image:UIImage){
        var origImageSize = image.size
        var newRect = CGRectMake(0, 0, 40, 40)
        
        var ratio = max(newRect.size.width / origImageSize.width, newRect.size.height / origImageSize.height)
        UIGraphicsBeginImageContextWithOptions(newRect.size, false, 0.0)
        var path = UIBezierPath(roundedRect: newRect, cornerRadius: 5.0)
        path.addClip()
        
        var projectRect = CGRect()
        projectRect.size.width = ratio * origImageSize.width
        projectRect.size.height = ratio * origImageSize.height
        projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0
        projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0
        
        image.drawInRect(projectRect)
        
        var smallImage = UIGraphicsGetImageFromCurrentImageContext()
        thumbnail = smallImage
        
        UIGraphicsEndImageContext()
        
        
    }
    
    
}
