//
//  User+CoreDataProperties.swift
//  CoDa
//
//  Created by kiran on 9/23/18.
//  Copyright © 2018 kiran. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?

}
