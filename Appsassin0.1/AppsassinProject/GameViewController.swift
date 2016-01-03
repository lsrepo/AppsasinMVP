//
//  GameViewController.swift
//  Appsassin0.1
//
//  Created by Pak on 13/12/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class GameViewController: UIViewController {
    
    @IBOutlet weak var profilePic: PFImageView!
    
        func loadImage() {
            
            let query = PFQuery(className:"Player")
            query.whereKey("objectId", equalTo:nsa.targetPlayerId)
            let _ = query.getFirstObjectInBackgroundWithBlock {  (imgObj:PFObject?, error:NSError?) -> Void in
                if error == nil {
                    print("//GameView:imgObj is\(imgObj)")
                    print("//GameView:Loading image")
                    //let imageView = PFImageView()
                    self.profilePic.image = UIImage(named: "...") // placeholder image
                    self.profilePic.file = imgObj!["image"] as? PFFile // remote image
                    self.profilePic.loadInBackground()
                    self.profilePic.layer.masksToBounds = true;
                    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
                    
                    //self.profilePic = imageView
    
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
       self.view.backgroundColor = UIColor.blackColor()
        loadImage();
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
