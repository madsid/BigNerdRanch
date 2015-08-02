//
//  BNRImageStore.swift
//  BNRHomepwner
//
//  Created by sid on 5/25/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRImageStore: NSObject {
    private var dictionary = [String: UIImage]()
    
    static let sharedStore:BNRImageStore = BNRImageStore()
    
    private override init(){}
    
    func setImage(image:UIImage, key:String){
        self.dictionary[key] = image
    }
    
    func imageForKey(imagekey:String) -> UIImage?{
        return self.dictionary[imagekey]
    }
    
    func deleteImageForKey(imageKey:String){
        self.dictionary.removeValueForKey(imageKey)
    }
}
