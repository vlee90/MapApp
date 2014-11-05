//
//  Reminder.swift
//  MapApp
//
//  Created by Vincent Lee on 11/4/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Foundation
import CoreData

class Reminder: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var date: NSDate
    @NSManaged var radius: NSNumber
    @NSManaged var coordinate: String

}
