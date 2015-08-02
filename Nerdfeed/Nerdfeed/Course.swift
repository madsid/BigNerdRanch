//
//  Course.swift
//  Nerdfeed
//
//  Created by sid on 5/30/15.
//  Copyright (c) 2015 madsid. All rights reserved.
//

import Foundation

class Course {
    
    var title:String?
    var url:String?
    var upcoming:[Upcoming]
    
    init(){
        title = ""
        url = ""
        upcoming = [Upcoming]()
    }
    
}

class Upcoming {
    var endDate:String?
    var startDate:String?
    var location:String?
    var instructors:String?
    
    init(){
        endDate = ""
        startDate = ""
        location = ""
        instructors = ""
    }
}