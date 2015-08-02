//
//  BNRItemsViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController, UITableViewDataSource {
    
    var itemsLessThan50 = [BNRItem]()
    var itemsGreaterThan50 = [BNRItem]()
    var itemsections = [[]]
    
    init(){
        super.init(style: UITableViewStyle.Plain)
        for(var i = 0; i < 5; i++){
            BNRItemStore.sharedStore.createItem()
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "logo.png"))
        
        
        
        for item in BNRItemStore.sharedStore.allItems {
            if(item.valueInDollars > 50){
                itemsGreaterThan50.append(item)
            }
            else{
                itemsLessThan50.append(item)
            }
        }
        
        itemsections = [itemsLessThan50,itemsGreaterThan50,["No More Items!"]]
        
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemsections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0: return "Value < 50"
        case 1: return "Value > 50"
        case 2: return nil
        default: return "Unknown"
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ( itemsections.count-1 > indexPath.section ){
            return CGFloat(60)
        }
        return CGFloat(44)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsections[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        var myItem: AnyObject = itemsections[indexPath.section][indexPath.row]
        
        if let item = myItem as? BNRItem{
            cell.textLabel?.text = item.description
            cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 20)
        }
        else{
            cell.textLabel?.text = myItem as? String
        }
        
        
        
        return cell
    }
    
}
