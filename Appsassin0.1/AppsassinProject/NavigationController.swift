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
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0/255.0, alpha: 1.0)

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33/255.0, alpha: 1.0)]

        UITabBar.appearance().tintColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0/255.0, alpha: 1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
