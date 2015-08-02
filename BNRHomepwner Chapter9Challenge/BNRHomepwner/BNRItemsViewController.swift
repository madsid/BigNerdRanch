//
//  BNRItemsViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController, UITableViewDataSource {
    
    
    var _headerView:UIView?
    
    @IBOutlet var headerView:UIView! {
        get{
            if(_headerView == nil){
                NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)
            }
            return _headerView
        }
        set{
            _headerView = newValue
        }
        
    }
    
    init(){
        super.init(style: UITableViewStyle.Plain)
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        var header:UIView = self.headerView
        self.tableView.tableHeaderView = header
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    @IBAction func addNewItem(sender:UIButton){
        //var lastRow = self.tableView.numberOfRowsInSection(0)
        //var indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        //self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
        var newItem = BNRItemStore.sharedStore.createItem()
        
        if let index = find(BNRItemStore.sharedStore.allItems, newItem) {
            var indexPath = NSIndexPath(forRow: index, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        }
        
        
    }
    
    @IBAction func toggleEditingMode(sender:UIButton){
        
        if(self.editing){
            sender.setTitle("Edit", forState: .Normal)
            self.setEditing(false, animated: true)
        }
        else{
            sender.setTitle("Done", forState: .Normal)
            self.setEditing(true, animated: true)
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.sharedStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        var items = BNRItemStore.sharedStore.allItems
        var item = items[indexPath.row]
        
        cell.textLabel?.text = item.description
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            var items = BNRItemStore.sharedStore.allItems
            var item = items[indexPath.row]
            BNRItemStore.sharedStore.removeItem(item)
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        BNRItemStore.sharedStore.moveItem(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "Remove"
    }
    
}
