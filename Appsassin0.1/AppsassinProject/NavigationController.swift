//
//  NavigationController.swift
//  Appsassin0.1
//
//  Created by Catherine Hedler on 20/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        //self.navigationBar.barStyle = UIBarStyle.Black
        //self.navigationBar.tintColor = UIColor.blackColor()
        
        // Navigation bar
        UINavigationBar.appearance().barTintColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0/255.0, alpha: 1.0)
        //UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33/255.0, alpha: 1.0)]
        
        // Customizing the tab bar
        UITabBar.appearance().tintColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33/255.0, alpha: 1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
