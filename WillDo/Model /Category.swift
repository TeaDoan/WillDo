//
//  Category.swift
//  WillDo
//
//  Created by Thao Doan on 2/20/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category: Object {
    // Category is subclass of Object superclass in oder to save our data. It has a "name" property in this case.
    @objc dynamic var name:String = ""
    @objc dynamic var colour:String = ""
    
     let items = List<Item>()
    // forward relationship between Category and Items. Each category can have a number  of items 
}


