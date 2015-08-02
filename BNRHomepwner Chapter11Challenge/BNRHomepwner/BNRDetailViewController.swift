//
//  BNRDetailViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/25/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    var item:BNRItem!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBAction func backgroundTapped(sender: UIControl) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        var imagePicker = UIImagePickerController()
        if( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
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
        
        var imageToDisplay = BNRImageStore.sharedStore.imageForKey(self.item.itemKey)
        self.imageView.image = imageToDisplay
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
        var item:BNRItem = self.item
        item.itemName = self.nameField.text
        item.serialNumber = self.serialField.text
        item.valueInDollars = self.valueField.text.toInt()!
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        BNRImageStore.sharedStore.setImage(image, key: self.item.itemKey)
        
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
