import UIKit

class BNRItem: NSObject , Printable {
    var _itemName:String!
    var _serialNumber:String!
    var _valueInDollers:Int!
    var _dateCreated:NSDate = NSDate()
    var _itemKey:String!
    
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
        
        var uuid = NSUUID()
        self.itemKey = uuid.UUIDString

    }
    
    var itemName:String {
        get{
            return self._itemName
        }
        set{
            self._itemName = newValue
        }
    }
    
    var serialNumber:String {
        get{
            return self._serialNumber
        }
        set{
            self._serialNumber = newValue
        }
        
    }
    
    var valueInDollars:Int{
        get{
            return self._valueInDollers
        }
        set{
            self._valueInDollers = newValue
        }
    }
    
    var dateCreated:NSDate{
        get{
            return self._dateCreated
        }
    }
    
    var itemKey:String{
        get{
            return self._itemKey
        }
        set{
            self._itemKey = newValue
        }
    }
    
    func randomItem() -> BNRItem{
        var randomAdjectiveList = ["Fluffy","Rusty","Shiny"]
        var randomNounList = ["Bear","Spork","Mac"]
        var adjectiveIndex = Int(rand()) % randomAdjectiveList.count
        var nounIntex = Int(rand()) % randomNounList.count
        var randomName = " \(randomAdjectiveList[adjectiveIndex])  \(randomNounList[adjectiveIndex])"
        var randomValue = Int(rand()) % 100
        var randomSerialNumber:String = "A\(Int(rand()) % 9)B\(Int(rand()) % 9)C" //change this to randomly generate
        var newItem = BNRItem()
        newItem.initWIthItemNameValueInDollarsSerialNumber(randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        return newItem
    }
    
}