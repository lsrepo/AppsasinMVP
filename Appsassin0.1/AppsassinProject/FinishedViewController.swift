//
//  FinishedViewController.swift
//  Appsassin0.1
//
//  Created by Pak on 17/12/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    @IBAction func moveOnButton(sender: UIButton) {
        print("running navigation")
        let LeaderboardTableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderboardTableViewController") as! UITableViewController
        self.presentViewController(LeaderboardTableViewController, animated: true, completion: nil)
        
    }
    @IBAction func moveToLeaderboardButton(sender: AnyObject) {
        
        print("running navigation")
        
//        let LeaderboardTableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderboardTableViewController") as UIViewController
//        self.presentViewController(LeaderboardTableViewController, animated: true, completion: nil)
    }
   
    @IBOutlet weak var finishedImageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.finishedImageView.image = nsa.cameraImageFromMe
            //nsa.cameraImageFromMe
        
        
//        self.profilePic.image = UIImage(named: "...") // placeholder image
//        self.profilePic.file = imgObj!["image"] as? PFFile // remote image
//        self.profilePic.loadInBackground()
        
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
