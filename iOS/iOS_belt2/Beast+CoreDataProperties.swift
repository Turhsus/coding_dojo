//
//  Beast+CoreDataProperties.swift
//  iOS_belt2
//
//  Created by Sushrut Athavale on 7/22/16.
//  Copyright © 2016 Sushrut Athavale. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beast {

    @NSManaged var details: String?
    @NSManaged var timeBeasted: NSDate?

}
