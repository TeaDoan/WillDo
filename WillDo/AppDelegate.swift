//
//  AppDelegate.swift
//  WillDo
//
//  Created by Thao Doan on 2/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            _ = try Realm()
            
        }
        catch {
            print ( "Error initialising new realm,\(error)")
        }
        
        return true

      
    }

    

  
    
    

}

