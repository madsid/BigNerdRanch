//
//  BNRDetailViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/25/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate {
    var item:BNRItem?
    var imagePickPopover:UIPopoverController!
    var dismissBlock:(() -> ())?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UIButton!
    @IBOutlet weak var serialLabel: UIButton!
    @IBOutlet weak var valueLabel: UIButton!
    
    @IBAction func backgroundTapped(sender: UIControl) {
        self.view.endEditing(true)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        NSException(name: "Wrong Initializer", reason: "Use init(new:Bool) ", userInfo: nil).raise()
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(new:Bool){
        super.init(nibName: "BNRDetailViewController", bundle: nil)
        if(new){
            var doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("save:"))
            navigationItem.rightBarButtonItem = doneItem
            
            var cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("cancel:"))
            navigationItem.leftBarButtonItem = cancelItem
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UpdateFonts(){
        var font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        //TODO: I messed up the label's with buttons, should change later
    }
    
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        if( imagePickPopover != nil && imagePickPopover.popoverVisible){
            imagePickPopover.dismissPopoverAnimated(true)
            imagePickPopover = nil
            return
        }
        
        var imagePicker = UIImagePickerController()
        if( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad){
            imagePickPopover = UIPopoverController(contentViewController: imagePicker)
            imagePickPopover.delegate = self
            imagePickPopover.presentPopoverFromBarButtonItem(sender, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
        else{
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        println("User Dismissed Popover")
        imagePickPopover = nil
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var io = UIApplication.sharedApplication().statusBarOrientation
        prepareViewforOrientation(io)
        
        self.navigationItem.title = self.item!.itemName
        
        var item:BNRItem = self.item!
        
        self.nameField.text = item.itemName
        self.serialField.text = item.serialNumber
        self.valueField.text = "\(item.valueInDollars)"
        
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
        var imageToDisplay = BNRImageStore.sharedStore.imageForKey(self.item!.itemKey)
        self.imageView.image = imageToDisplay
        
        UpdateFonts()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        
        var item:BNRItem = self.item!
        item.itemName = self.nameField.text
        item.serialNumber = self.serialField.text
        item.valueInDollars = self.valueField.text.toInt()!
    }
    
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        prepareViewforOrientation(toInterfaceOrientation)
    }
    
    
    func prepareViewforOrientation(orientation:UIInterfaceOrientation){
        if( UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad ){
            return
        }
        
        if( UIInterfaceOrientationIsLandscape(orientation)){
            imageView.hidden = true
            cameraButton.enabled = false
        }
        else{
            imageView.hidden = false
            cameraButton.enabled = true
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        item?.setThumbnailFromImage(image)
        
        BNRImageStore.sharedStore.setImage(image, key: self.item!.itemKey)
        
        self.imageView.image = image
        
        if(imagePickPopover != nil){
            imagePickPopover.dismissPopoverAnimated(true)
            imagePickPopover = nil
        }
        else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func save(sender:AnyObject){
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: dismissBlock)
    }
    
    func cancel(sender:AnyObject){
        BNRItemStore.sharedStore.removeItem(item!)
        presentingViewController?.dismissViewControllerAnimated(true, completion: dismissBlock)
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
