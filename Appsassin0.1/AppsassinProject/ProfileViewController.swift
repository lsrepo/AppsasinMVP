
//
//  LogInViewController.swift
//  Appsassin0.1
//
//  Created by Pak on 13/12/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileIV: UIImageView!
   
    @IBAction func reactivateAllButton(sender: AnyObject) {
        self.reactivateAll();
    }
    @IBAction func activateButton(sender: AnyObject) {
        self.activateGameMode();
    }
    
    @IBAction func searchPlayerButton(sender: AnyObject) {
        self.searchPlayers();
    }

    @IBAction func deactivateButton(sender: AnyObject) {
        self.deactivateGameMode();
    }
    
    @IBOutlet weak var targetLabel: UILabel!
    
    var myPlayerId = PFUser.currentUser()!["player"].objectId!!
    var targetUserId:String = "";
    var targetPlayerId:String = "";
    var targetUsername:String=""
    var myUsername = PFUser.currentUser()!["username"] as! String
    
    func reactivateAll(){
        gameStateChanger(true, isMatched: false, playerId: "ng98K9gGyX")
        gameStateChanger(true, isMatched: false, playerId: "g326VU11Do")
        gameStateChanger(true, isMatched: false, playerId: "28r6nJ1769")
        gameStateChanger(true, isMatched: false, playerId: "qbWwNYCi8j")
    }
    
    func gameStateChanger(isActive: Bool,isMatched: Bool,playerId: String){
        
        let playerQuery = PFQuery(className:"Player")
        playerQuery.getObjectInBackgroundWithId(playerId) {
            (playerObj: PFObject?, error: NSError?) -> Void in
            if error == nil  {
                //print(mePlayer!)
                playerObj!["isActive"] = isActive;
                playerObj!["isMatched"] = isMatched;
                playerObj!.saveInBackground()
                print("-\(playerObj)")
            } else {
                print("\(error!) gameStateChangerError")
            }
        }
    }
    
    func deactivateGameMode(){
        gameStateChanger(false,isMatched: false,playerId: myPlayerId)
        self.targetPlayerId="";
        print("targetPlayerId is now empty: \(targetPlayerId)")
        
    }
    
    func assignTargets(){
        print("now we try to assign")
        print("myPlayerId is \(self.myPlayerId)")
        print("targetPlayer is \(self.targetPlayerId)")
        gameStateChanger(true, isMatched: true, playerId: self.myPlayerId)
        gameStateChanger(true, isMatched: true, playerId: self.targetPlayerId)
        print("Both Players are deactiveted")
        pushAssignments(self.myPlayerId, targetedName: self.targetUsername)
        pushAssignments(self.targetPlayerId, targetedName: self.myUsername)

    }
    
    func pushAssignments(targetedPlayerId:String,targetedName:String){
        // Find players in Player
        let playerQuery = PFQuery(className:"Player")
        playerQuery.whereKey("objectId", equalTo: targetedPlayerId )
        
        // Find devices associated with these users
        let pushQuery = PFInstallation.query()
        pushQuery!.whereKey("player", matchesQuery: playerQuery)
        
        // Send push notification to query
        let push = PFPush()
        push.setQuery(pushQuery) // Set our Installation query
        push.setMessage("You're now assigned to terminate agent \(targetedName)    /M")
        push.sendPushInBackground()
    }

    func activateGameMode(){
        gameStateChanger(true,isMatched: false,playerId: myPlayerId)
        searchPlayers();
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Send push notifications to the two assigned players
        
        //find target user's userobject
        //get targer's installation id, put it in PFinstallationQuery
        
        
        
        //you need to be logged in to do that
        //addImage();
        
        loadImage();
        
    }
    
//    func loadImage() {
//        print("loading image")
//        let query = PFQuery(className:"Player")
//        query.whereKey("objectId", equalTo:"g326VU11Do")
//        let _ = query.getFirstObjectInBackgroundWithBlock {  (imgObj:PFObject?, error:NSError?) -> Void in
//            if error == nil {
//                print(imgObj)
//                print("loading result")
//                let imageView = PFImageView()
//                imageView.image = UIImage(named: "...") // placeholder image
//                imageView.file = imgObj!["image"] as? PFFile // remote image
//                
//                imageView.loadInBackground()
//               
//            }
//        }
//    }

    func loadImage() {
        print("loading image")
        let query = PFQuery(className:"Player")
        query.whereKey("objectId", equalTo:"28r6nJ1769")
        _ = query.getFirstObjectInBackgroundWithBlock {  (imgObj:PFObject?, error:NSError?) -> Void in
            if error == nil {
                print(imgObj)
                print("loading result")
                let img = imgObj!["image"]
                let imageView: PFImageView = PFImageView()
                imageView.file = img as? PFFile
                imageView.loadInBackground({
                    (photo, error) -> Void in
                    if error == nil {
                        print("loading alert")
//                        self.profileIV.image =
                        
                        let alert = UIAlertController(title: "You have a message", message: "Message from ", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                            (action) -> Void in
                            
                            
                            let backgroundView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                            backgroundView.backgroundColor = UIColor.blackColor()
                            backgroundView.alpha = 0.8
                            backgroundView.tag = 10
                            backgroundView.contentMode = UIViewContentMode.ScaleAspectFit
                            self.view.addSubview(backgroundView)
                            
                            let displayedImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                            displayedImage.image = photo
                            displayedImage.tag = 10
                            displayedImage.contentMode = UIViewContentMode.ScaleAspectFit
                            
                            self.view.addSubview(displayedImage);

                            _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "hideMessage", userInfo: nil, repeats: false)

                            }
                            )
                        )
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                        
                    }
                    else {
                        print(error)
                    }
                    
                    }
                )
                
            }
        }
    }


    
    func hideMessage() {
        
        for subview in self.view.subviews {
            if subview.tag == 10 {
                subview.removeFromSuperview()
            }
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GVC: UIViewController  = storyboard.instantiateViewControllerWithIdentifier("GameViewController")  as UIViewController
        self.presentViewController(GVC, animated: true, completion: nil)
        
    }

    
    

    
    func addImage(){
        let image = UIImage(named: "pak.jpg")
        let imageData = UIImageJPEGRepresentation(image!, 0.9)
        let imageFile = PFFile(name:"q.jpg", data:imageData!)
        
        var query = PFQuery(className:"Player")
        query.getObjectInBackgroundWithId("IZhi8dmPYn") {
            (playerObj: PFObject?, error: NSError?) -> Void in
            if error == nil && playerObj != nil {
                print(playerObj)
                playerObj!["image"] = imageFile
                playerObj!.saveInBackground()
            } else {
                print(error)
            }
        }
    }
    
    func searchPlayers(){
        // Find active, unmatched player nearby
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                //Send current location to Parse
                PFUser.currentUser()!["location"] = geoPoint;
                PFUser.currentUser()!.saveInBackground()
                
                //print(geoPoint)
                //print(PFUser.currentUser()!.objectId!)
                
                // Create a query for places
                let userQuery = PFUser.query()
                
                // Interested in locations near user
                userQuery!.whereKey("location", nearGeoPoint: geoPoint!, withinKilometers: 0.05)
                
                // Exclude current user
                userQuery!.whereKey("objectId", notEqualTo:PFUser.currentUser()!.objectId!)
                
                // Get players who is active and unmatched in Player class
                userQuery!.includeKey("player");
                let playerQuery = PFQuery(className:"Player");
                playerQuery.whereKey("isActive",equalTo: true);
                playerQuery.whereKey("isMatched",equalTo: false);
                userQuery!.whereKey("player", matchesQuery: playerQuery)
                
                // Limit the query to 1 people
                userQuery!.limit = 1
                
                // Final list of objects
                userQuery!.findObjectsInBackgroundWithBlock {
                    (let objects: [PFObject]?, error: NSError?) -> Void in
                    self.targetLabel.text = "No target found"
                    if error == nil {
                        
                        let target = objects![0]
                        print("target[\"username\"]: \(target["username"])")
                        self.targetUsername = target["username"] as! String
                        print( " \(self.targetUsername) is your target")
                        let targetMsg = String(self.targetUsername) + " is your target!"
                        let targetPlayer = target["player"]
                        self.targetUserId = target.objectId!
                        print("targetUserId is \(self.targetUserId)")
                        self.targetPlayerId = targetPlayer.objectId!!
                        self.targetLabel.text = targetMsg
                        self.assignTargets();
                    } else {
                        // Error finding target in query
                        print("Error: \(error!)")
                    }
                }
            }
            else{
                print("findObject \(error)")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
            PFUser.logOut()
        }
    }
    
}