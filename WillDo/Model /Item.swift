//
//  Item.swift
//  WillDo
//
//  Created by Thao Doan on 2/20/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title:String = ""
   @objc dynamic var done :Bool = false
    
   
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    // creating a inverse relationship between items to a category. Set to a class of object LinkingOjects. Each category has a one or many relationship  with a list of items and each item is a inverse relationship.
    // Category.seft is type category, property is items point forward the ralationship

}
