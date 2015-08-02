//
//  BNRItemStore.swift
//  BNRHomepwner
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit
import CoreData

class BNRItemStore:NSObject {
    
    //static let sharedStore:BNRItemStore = BNRItemStore()
    private var privateItems = [BNRItem]()
    var allAssetTypes:[BNRItem]?
    var context:NSManagedObjectContext?
    var model:NSManagedObjectModel?
    
    
    class var sharedStore:BNRItemStore {
        struct singleton {
            static let singleInstance:BNRItemStore = BNRItemStore()
        }
        return singleton.singleInstance
    }
    
    private override init() {
        super.init()
        /*var path = itemArchivePath
        privateItems = (NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [BNRItem])
        
        if(privateItems == nil){
            privateItems = [BNRItem]()
        }*/
        
        model = NSManagedObjectModel.mergedModelFromBundles(nil)
        var psc = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        var path = itemArchivePath
        var storeURL = NSURL(fileURLWithPath: path)
        
        var error = NSErrorPointer()
        
        if((psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: error) ) == nil){
            //NSException.raise("Open Failure", format: error.debugDescription, arguments: listpointer)
        }
        
        context = NSManagedObjectContext()
        context?.persistentStoreCoordinator = psc
        
        loadAllItems()
        
    }
    
    var itemArchivePath:String{
        var documentDirectories = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true)
        var documentDirectory = documentDirectories.first as! String
        
        //return documentDirectory.stringByAppendingPathComponent("items.archive")
        return documentDirectory.stringByAppendingPathComponent("store.data")
    }
    
    func createItem() -> BNRItem{
        //var item = BNRItem().randomItem()
        //var item = BNRItem()
        var order:Double!
        if( allItems.count == 0 ){
            order = 1.0
        }
        else{
            order = privateItems.last!.orderingValue + 1.0
        }
        
        println("Adding After \(privateItems.count) items, order \(order)")
        
        var item = NSEntityDescription.insertNewObjectForEntityForName("BNRItem", inManagedObjectContext: context!) as? BNRItem
        item?.orderingValue = order
        
        self.privateItems.append(item!)
        return item!
    }
    
    var allItems:[BNRItem]{
        get{
            return privateItems
        }
    }
    
    func removeItem(item:BNRItem) {
        var index = find(self.privateItems, item)
        BNRImageStore.sharedStore.deleteImageForKey(item.itemKey)
        context?.deleteObject(item)
        self.privateItems.removeAtIndex(index!)
    }
    
    func moveItem(fromIndex:Int, toIndex:Int){
        if(fromIndex == toIndex){
            return
        }
        var item = self.privateItems[fromIndex]
        
        self.privateItems.removeAtIndex(fromIndex)
        self.privateItems.insert(item, atIndex: toIndex)
        
        var lowerBound = 0.0
        
        if(toIndex > 0 ){
            lowerBound = privateItems[toIndex - 1].orderingValue
        }
        else{
            lowerBound = privateItems[1].orderingValue - 2.0
        }
        
        var upperBound = 0.0
        
        if( toIndex < privateItems.count - 1 ){
            upperBound = privateItems[(toIndex + 1)].orderingValue
        }
        else{
            upperBound = privateItems[(toIndex - 1)].orderingValue + 2.0
        }
        
        var newOrderingValue = (lowerBound + upperBound) / 2.0
        
        println("moving to order \(newOrderingValue)")
        
        item.orderingValue = newOrderingValue
    
    }
    
    func saceChanges() -> Bool{
        /*var path = itemArchivePath
        return NSKeyedArchiver.archiveRootObject(privateItems, toFile: path) */
        
        var error = NSErrorPointer()
        var successful = context?.save(error)
        if( successful == nil ){
            println("Error saving \(error.debugDescription)")
        }
        return successful!
    }
    
    func loadAllItems(){
        if( !privateItems.isEmpty  ){
            var request = NSFetchRequest()
            var e = NSEntityDescription.entityForName("BNRItem", inManagedObjectContext: context!)
            request.entity = e
            
            var sd = NSSortDescriptor(key: "orderingValue", ascending: true)
            
            request.sortDescriptors = sd as AnyObject as? [AnyObject]
            
            var error = NSErrorPointer()
            
            var result = context?.executeFetchRequest(request, error: error)
            
            if( result == nil ){
                //NSEXception
            }
            
            privateItems = (result as? [BNRItem])!
        }
    }
    
    
}
