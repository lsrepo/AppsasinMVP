//
//  GameViewController.swift
//  Appsassin0.1
//
//  Created by Pak on 13/12/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
       self.view.backgroundColor = UIColor.blackColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "catchIt:", name: "myNotif", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Need to have this in some VC to receive push
    func catchIt(userInfo: NSNotification){
//        var notif = JSON(userInfo.valueForKey("userInfo")!)
//        // Check nil and do redirect here, for example:
//        if notif["type"] == "A"{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let gvc: UIViewController  = storyboard.instantiateViewControllerWithIdentifier("gvc") as UIViewController
//            self.presentViewController(gvc, animated: true, completion: nil)
//        }
//        else if notif["type"] == "B"{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let fvc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("fvc") as UIViewController
//            self.presentViewController(fvc, animated: true, completion: nil)
//        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
//    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let GVC: UIViewController  = storyboard.instantiateViewControllerWithIdentifier("GameViewController")  as UIViewController
//    self.presentViewController(GVC, animated: true, completion: nil)
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
