//
//  BNRItemStore.swift
//  BNRHomepwner
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRItemStore:NSObject {
    
    static let sharedStore:BNRItemStore = BNRItemStore()
    private var privateItems = [BNRItem]()
    
    private override init() {}
    
    func createItem() -> BNRItem{
        var item = BNRItem().randomItem()
        self.privateItems.append(item)
        return item
    }
    
    var allItems:[BNRItem]{
        get{
            return privateItems
        }
    }
    
    func removeItem(item:BNRItem) {
        var index = find(self.privateItems, item)
        self.privateItems.removeAtIndex(index!)
    }
    
    func moveItem(fromIndex:Int, toIndex:Int){
        if(fromIndex == toIndex){
            return
        }
        var item = self.privateItems[fromIndex]
        
        self.privateItems.removeAtIndex(fromIndex)
        self.privateItems.insert(item, atIndex: toIndex)
    }
    
    
    
}
