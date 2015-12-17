/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import SwiftyJSON


// If you want to use any of the UI components, uncomment this line
// import ParseUI

// If you want to use Crash Reporting - uncomment this line
// import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Customizing the tab bar
        UITabBar.appearance().tintColor = UIColor.redColor()
        
        // Enable storing and querying data from Local Datastore.
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
        Parse.enableLocalDatastore()

        // ****************************************************************************
        // Uncomment this line if you want to enable Crash Reporting
        // ParseCrashReporting.enable()
        //
        // Uncomment and fill in with your Parse credentials:
        Parse.setApplicationId("065DUC1XuH7Rl4OHftyh5qieeLWfdZBm9kcx0EBP",
            clientKey: "iH84fRB441R8JtIBikTuXr4k5VSJRrTDqkemvdkl")
        //
        // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
        // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
        // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
        // PFFacebookUtils.initializeFacebook()
        // ****************************************************************************

        PFUser.enableAutomaticUser()

        let defaultACL = PFACL();

        // If you would like all objects to be private by default, remove this line.
        defaultACL.publicReadAccess = true

        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)

        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.

            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var noPushPayload = false;
            // call this function manually when the app is launched due to a push notification. ​
            if let options = launchOptions {
                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
            }
            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }

        //
        //  Swift 1.2
        //
//                if application.respondsToSelector("registerUserNotificationSettings:") {
//                    let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
//                    let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
//                    application.registerUserNotificationSettings(settings)
//                    application.registerForRemoteNotifications()
//                } else {
//                    let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
//                    application.registerForRemoteNotificationTypes(types)
//                }

        //
        //  Swift 2.0
        
                if #available(iOS 8.0, *) {
                    let types: UIUserNotificationType = [.Alert, .Badge, .Sound]
                    let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
                    application.registerUserNotificationSettings(settings)
                    application.registerForRemoteNotifications()
                } else {
                    let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
                    application.registerForRemoteNotificationTypes(types)
                }
        
        print("hej")
//        // Extract the notification data
//        if let notificationPayload = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
//            print("loading notification meta data")
//            // Create a pointer to the Photo object
//            let photoId = notificationPayload["p"] as? NSString
//            print(" p is \(notificationPayload["p"])")
//            print(" photoId is \(photoId)")
//            let targetPhoto = PFObject(withoutDataWithClassName: "Photo", objectId: "dfd")
//            
//            // Fetch photo object
//            targetPhoto.fetchIfNeededInBackgroundWithBlock {
//                (object: PFObject?, error:NSError?) -> Void in
//                if error == nil {
//                    // Show photo view controller
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let GVC: UIViewController  = storyboard.instantiateViewControllerWithIdentifier("GameViewController")  as UIViewController
//                    //PhotoVC(photo: object);
//                    GVC.presentViewController(GVC, animated: true, completion: nil);
//                    
//                }
//            }
//        }
        return true
    }

    //--------------------------------------
    // MARK: Push Notifications
    //--------------------------------------

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()

        PFPush.subscribeToChannelInBackground("") { (succeeded: Bool, error: NSError?) in
            if succeeded {
                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
            } else {
                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error)
            }
        }
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
        }
    }
    


    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        PFPush.handlePush(userInfo)
//        print(userInfo)
//        print("this is 1st")

        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
        //Receiving push notification
        let notif = JSON(userInfo) // SwiftyJSON required
        
    }
    
    func clearBadges() {
        let installation = PFInstallation.currentInstallation()
        installation.badge = 0
        installation.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("cleared badges")
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            }
            else {
                print("failed to clear badges")
            }
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        clearBadges()
    }

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you want to use Push Notifications with Background App Refresh
    ///////////////////////////////////////////////////////////
//     func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//        
//         if application.applicationState == UIApplicationState.Inactive {
//             PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
//         }
//        PFPush.handlePush(userInfo)
//        print(userInfo["aps"]!["alert"])
//        print("When Screen is OFF! it pops up")
//        
//        
//        
//     }

    //--------------------------------------
    // MARK: Facebook SDK Integration
    //--------------------------------------

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you are using Facebook
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    //     return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
    // }
   
}
