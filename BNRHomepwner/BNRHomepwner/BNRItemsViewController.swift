//
//  BNRItemsViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController, UITableViewDataSource, UIPopoverControllerDelegate {
    var imagePopover:UIPopoverController?
    /* Chapter 9
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
    */
    
    init(){
        super.init(style: UITableViewStyle.Plain)
        var navItem = self.navigationItem
        navItem.title = "Homepwner"
        
        var bbi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add , target: self, action: Selector("addNewItem:"))
        
        navItem.rightBarButtonItem = bbi
        navItem.leftBarButtonItem = self.editButtonItem()
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        var nib = UINib(nibName: "BNRItemCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "BNRItemCell")
        /*Used until chapter 9
        var header:UIView = self.headerView
        self.tableView.tableHeaderView = header
        */
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @IBAction func addNewItem(sender:UIButton){
        var newItem = BNRItemStore.sharedStore.createItem()
        
        var detailViewController = BNRDetailViewController(new: true)
        detailViewController.item = newItem
        detailViewController.dismissBlock = {
            self.tableView.reloadData()
        }
        var navController = UINavigationController(rootViewController: detailViewController)
        navController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        presentViewController(navController, animated: true, completion: nil)
        
        /*
        if let index = find(BNRItemStore.sharedStore.allItems, newItem) {
            var indexPath = NSIndexPath(forRow: index, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        }
        */
        
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
        //var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        var cell = tableView.dequeueReusableCellWithIdentifier("BNRItemCell", forIndexPath: indexPath) as! BNRItemCell
        var items = BNRItemStore.sharedStore.allItems
        var item = items[indexPath.row]
        
        //cell.textLabel?.text = item.description
        
        cell.nameLabel.text = item.itemName
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.tumbnailView.image = item.thumbnail
        
        cell.actionBlock = {
            println("Going to show image for \(item)")
            
            if( UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad ){
                var itemKey = item.itemKey
                var img = BNRImageStore.sharedStore.imageForKey(itemKey)
                if(img == nil){
                    return
                }
                
                var rect = self.view.convertRect(cell.tumbnailView.bounds, fromView: cell.tumbnailView)
                var ivc = BNRImageViewController()
                ivc.image = img
                self.imagePopover = UIPopoverController(contentViewController: ivc)
                self.imagePopover?.delegate = self
                self.imagePopover?.popoverContentSize = CGSizeMake(600, 600)
                self.imagePopover?.presentPopoverFromRect(rect, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
                
            }
            
        }
        
        return cell
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        imagePopover = nil
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var detailViewController = BNRDetailViewController(new: false)
        
        var items = BNRItemStore.sharedStore.allItems
        var selctedItem = items[indexPath.row]
        detailViewController.item = selctedItem
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
