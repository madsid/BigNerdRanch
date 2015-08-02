//
//  BNRImageViewController.swift
//  BNRHomepwner
//
//  Created by sid on 5/30/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRImageViewController: UIViewController {
    
    var image:UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.view = imageView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var imageVIew = self.view as! UIImageView
        imageVIew.image = image
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
