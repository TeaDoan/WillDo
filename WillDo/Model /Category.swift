//
//  Category.swift
//  WillDo
//
//  Created by Thao Doan on 2/20/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name:String = ""
    
     let items = List<Item>()
    // forward relationship between Category and Items.
}


