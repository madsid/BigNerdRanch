//
//  BNRDetailViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/25/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRDetailViewController: UIViewController, UITextFieldDelegate {
    var item:BNRItem!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        valueField.keyboardType = UIKeyboardType.NumberPad
        
        valueField.delegate = self
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == valueField){
             //var bbi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done , target: self, action: Selector("returnKeyboard:"))
            var bbi = UIBarButtonItem()
            bbi.title = "Done"
            bbi.style = .Done
            bbi.target = self
            bbi.action = Selector("removeKeyboard")
            self.navigationItem.rightBarButtonItem = bbi
        }
    }
    
    func removeKeyboard(){
            self.valueField.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.item.itemName
        
        var item:BNRItem = self.item
        
        self.nameField.text = item.itemName
        self.serialField.text = item.serialNumber
        self.valueField.text = "\(item.valueInDollars)"
        
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
        var item:BNRItem = self.item
        item.itemName = self.nameField.text
        item.serialNumber = self.serialField.text
        item.valueInDollars = self.valueField.text.toInt()!
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
