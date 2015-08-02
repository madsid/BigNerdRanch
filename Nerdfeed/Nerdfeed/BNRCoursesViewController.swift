//
//  BNRCoursesViewController.swift
//  Nerdfeed
//
//  Created by sid on 5/30/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import UIKit

class BNRCoursesViewController: UITableViewController {
    var session:NSURLSession?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        navigationItem.title = "BNR Courses"
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)

        
        fetchFeed()
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        return cell
    }
    
    func fetchFeed(){
        var requestString = "http://bookapi.bignerdranch.com/courses.json"
        var url = NSURL(string: requestString)!
        var req = NSURLRequest(URL: url)
        var dataTask = session!.dataTaskWithRequest(req, completionHandler: {(data,response,error) in
            var jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            var courses = jsonObject["courses"] as! NSArray
            
            for( var i = 0 ; i < courses.count ; i++ ){
                var course = courses[i] as! NSDictionary
                
                var tempCourse:Course
                
                
                var title = course["title"] as? String
                var url = course["url"] as? String
                var upcoming = [Upcoming]()
                
                var upcomingArray = course["upcoming"] as? [AnyObject]
                
                for( var j = 0 ; j < upcomingArray!.count ; j++  ){
                    var data = upcomingArray![j] as! NSDictionary
                    
                    var tempUpcoming = Upcoming()
                    
                    var endDate = data["end_date"] as! String
                    var startDate = data["start_date"] as! String
                    var instructors = data["instructors"] as! String
                    var location = data["location"] as! String
                    
                    tempUpcoming.endDate = endDate
                    tempUpcoming.startDate = startDate
                    tempUpcoming.instructors = instructors
                    tempUpcoming.location = location
                    
                    upcoming.append(tempUpcoming)
                }
                
                tempCourse.title = title
                tempCourse.url = url
                tempCourse.upcoming = upcoming
                
                Course.courses.addItem(tempCourse)
            }
            
            
            
        })
        dataTask.resume()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
