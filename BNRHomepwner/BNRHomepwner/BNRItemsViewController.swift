//
//  BNRItemsViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/24/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRItemsViewController: UITableViewController, UITableViewDataSource {
    
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
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
    
}
