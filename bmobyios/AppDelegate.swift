//
//  AppDelegate.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCIZFHLtJDhYg0i3rhvl0QQPfB7sLpo7BQ")
        GMSPlacesClient.provideAPIKey("AIzaSyCIZFHLtJDhYg0i3rhvl0QQPfB7sLpo7BQ")
        // CONFIGURATION OF PARSE
        let parseConfig = ParseClientConfiguration { (ParseMutableClientConfiguration) in
            
            //Accessing heroku App vio ID & Keys
            ParseMutableClientConfiguration.applicationId = "ms30091989mo11071987Bmoby"
            ParseMutableClientConfiguration.clientKey = "bmobyKeyBmobyiOsOS1107198730091989"
            ParseMutableClientConfiguration.server = "http://bmoby.herokuapp.com/parse"
        }
        
        Parse.initializeWithConfiguration(parseConfig)
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

