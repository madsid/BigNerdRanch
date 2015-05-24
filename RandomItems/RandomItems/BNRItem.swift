//
//  BNRItem.swift
//  RandomItems
//
//  Created by sid on 5/21/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import Cocoa

class BNRItem: NSObject , Printable {
    var _itemName:String = ""
    var _serialNumber:String = ""
    var _valueInDollers:Int = 0
    var _dateCreated:NSDate = NSDate()
    
    override var description:String {
        return "\(self.itemName) (\(self.serialNumber)) : worth \(self.valueInDollars) Recorded on  \(self.dateCreated)"
    }
    
    override init(){
        super.init()
        self.initWithItemName("Item Name")
    }
    
    
    func initWithItemName(itemName:String){
        self.initWIthItemNameValueInDollarsSerialNumber(itemName, valueInDollars: 0, serialNumber: "")
    }
    
    func initWIthItemNameValueInDollarsSerialNumber(itemName:String, valueInDollars:Int, serialNumber:String){
        super.self()
        
        self.itemName = itemName
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        
    }
    
    var itemName:String {
        get{
            return self._itemName
        }
        set(item){
            self._itemName = item
        }
    }
    
    var serialNumber:String {
        get{
            return self._serialNumber
        }
        set(serial){
            self._serialNumber = serial
        }
        
    }
    
    var valueInDollars:Int{
        get{
            return self._valueInDollers
        }
        set(value){
            self._valueInDollers = value
        }
    }
    
    var dateCreated:NSDate{
        get{
            return self._dateCreated
        }
    }
    
    func randomItem() -> BNRItem{
        var randomAdjectiveList:Array = ["Fluffy","Rusty","Shiny"]
        var randomNounList:Array = ["Bear","Spork","Mac"]
        var adjectiveIndex = Int(arc4random()) % randomAdjectiveList.count
        var nounIntex = Int(arc4random()) % randomNounList.count
        var randomName = " \(randomAdjectiveList[adjectiveIndex])  \(randomNounList[adjectiveIndex])"
        var randomValue = Int(arc4random()) % 100
        var randomSerialNumber:String = "A1B2C" //should change this to randomly generate
        var newItem = BNRItem()
        newItem.initWIthItemNameValueInDollarsSerialNumber(randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        return newItem
    }
    
}

class BNRContainer:BNRItem {
    
    var _items = [BNRItem]()
    var _containerName:String = ""
    
    func addItem(item:BNRItem){
        _items.append(item)
    }
    
    func getItems() -> [BNRItem]{
        return self._items
    }
    
    var containerName:String {
        get{
            return self._containerName
        }
        set(item){
            self._containerName = item
        }
    }
    
    deinit{
        println("Destroyed \(self)")
    }
    
    
    override var description:String {
        
        var totalValueInDollars:Int = 0
        var itemsNames:String = ""
        
        for item in _items {
            totalValueInDollars += item.valueInDollars
            itemsNames += "ItemName : \(item.itemName), \n "
        }
        
        return "Container Name : \(self.containerName) \n ValueInDollars : \(totalValueInDollars) \n \(itemsNames) "
    }
    
}
