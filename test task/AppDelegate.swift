//
//  AppDelegate.swift
//  test task
//
//  Created by Nikolai Borovennikov on 05.08.2020.
//  Copyright © 2020 monocar. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
//        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyCHmqIdu5jZS3wJc5oSzFcDlmhQ84eIcBk")
        
        return true
    }



}

