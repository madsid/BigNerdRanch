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
    
    class var sharedStore:BNRImageStore {
        struct singleton {
            static let singleInstance:BNRImageStore = BNRImageStore()
        }
        return singleton.singleInstance
    }
    
    private override init(){
        super.init()
        var nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: Selector("clearCache:"), name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }
    
    
    func setImage(image:UIImage, key:String){
        dictionary[key] = image
        var imagePath = imagePathForKey(key)
        var data = UIImageJPEGRepresentation(image, 0.5)
        data.writeToFile(imagePath, atomically: true)
    }
    
    func imageForKey(key:String) -> UIImage?{
        var result =  dictionary[key]
        if(result == nil){
            var imagePath = imagePathForKey(key)
            result = UIImage(contentsOfFile: imagePath)
            
            if(result != nil){
                dictionary[key] = result
            }
            else{
                println("Unable to find \(imagePath)")
            }
        }
        return result
    }
    
    func deleteImageForKey(key:String){
        dictionary.removeValueForKey(key)
        var imagePath = imagePathForKey(key)
        var defaultManager = NSFileManager()
        defaultManager.removeItemAtPath(imagePath, error: nil)
    }
    
    func imagePathForKey(key:String) -> String{
        var documentDirectories = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask , true)
        var documentDirectory = documentDirectories.first as! String
        return documentDirectory.stringByAppendingPathComponent(key)
    }
    
    func clearCache(note:NSNotification){
        println(" flusing \(dictionary.count) images out of the cache")
        dictionary.removeAll(keepCapacity: false)
    }
    
}
