//
//  AppDelegate.swift
//  NativePubNubChat
//
//  Created by Oliver Solano on 2/9/17.
//  Copyright © 2017 Oliver Solano. All rights reserved.
//

import UIKit
import CoreData
import PubNub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    // Stores reference on PubNub client to make sure what it won't be released.
    var client: PubNub!
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    



}

