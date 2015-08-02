//
//  BNRImageTransformer.swift
//  BNRHomepwner
//
//  Created by sid on 5/31/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRImageTransformer: NSValueTransformer {
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        
        if let data = value as? NSData {
            return data
        }
        else if let image = value as? UIImage {
            return UIImagePNGRepresentation(image)
        }
        return nil
    }
    
    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        if let data = value as? NSData {
            return UIImage(data: data)
        }
        return nil
    }
    
    
}


