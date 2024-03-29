
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

class mySingleton {
    //this is a singleton
    static let sharedInstance = mySingleton()
    
    //declare variables here
    var tmp:String = "";
    var myPlayerId:String = "";
    var targetUserId:String = "";
    var targetPlayerId:String = "";
    var targetUsername:String = "";
    var myUsername:String = "";
    var cameraImageFromMe:UIImage = UIImage()
    
    
    //declare functions here
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
    
    func reactivateAll(){
        nsa.gameStateChanger(true, isMatched: false, playerId: "ng98K9gGyX")
        nsa.gameStateChanger(true, isMatched: false, playerId: "g326VU11Do")
        nsa.gameStateChanger(true, isMatched: false, playerId: "28r6nJ1769")
        nsa.gameStateChanger(true, isMatched: false, playerId: "qbWwNYCi8j")
    }
    

    
    private init() {
        
    } //This prevents others from using the default '()' initializer for this class.
}

let nsa = mySingleton()

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileIV: UIImageView!
   
    @IBAction func reactivateAllButton(sender: AnyObject) {
        nsa.reactivateAll();
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
    
   
    
    func varInit(){
        nsa.myUsername = PFUser.currentUser()!["username"] as! String
        nsa.myPlayerId = PFUser.currentUser()!["player"].objectId!!
    }
    
    func deactivateGameMode(){
        nsa.gameStateChanger(false,isMatched: false,playerId: nsa.myPlayerId)
        nsa.targetPlayerId="";
        print("targetPlayerId is now empty: \(nsa.targetPlayerId)")
        
    }
    
    func activateGameMode(){
        nsa.gameStateChanger(true,isMatched: false,playerId: nsa.myPlayerId)
        self.searchPlayers();
        
    }
    
    func assignTargets(){
        print("now we try to assign")
        print("myPlayerId is \(nsa.myPlayerId)")
        print("targetPlayer is \(nsa.targetPlayerId)")
        nsa.gameStateChanger(true, isMatched: true, playerId: nsa.myPlayerId)
        nsa.gameStateChanger(true, isMatched: true, playerId: nsa.targetPlayerId)
        print("Both Players are deactiveted")
        pushAssignments(nsa.myPlayerId, targetedName: nsa.targetUsername)
        pushAssignments(nsa.targetPlayerId, targetedName: nsa.myUsername)

    }
    
    func pushAssignments(targetedPlayerId:String,targetedName:String){
        // Find players in Player
        let playerQuery = PFQuery(className:"Player")
        playerQuery.whereKey("objectId", equalTo: targetedPlayerId )
        
        // Find devices associated with these users
        let pushQuery = PFInstallation.query()
        pushQuery!.whereKey("player", matchesQuery: playerQuery)
        
        // Send push notification to query
        print("using PFpush in pushAssignment")
        let push = PFPush()
        
        var playerId:String = ""
        if (targetedPlayerId == nsa.myPlayerId){
            playerId = nsa.targetPlayerId
        }
        else{
            playerId = nsa.myPlayerId
        }
        let data = [
            "alert" : "You're now assigned to terminate agent \(targetedName)    /M",
            "badge" : "Increment",
            "sound" : "radar.wav",
            "type" : "A",
            "playerId" : playerId
        ]
        push.setData(data as [NSObject : AnyObject])
        push.setQuery(pushQuery) // Set our Installation query
//        push.setMessage("You're now assigned to terminate agent \(targetedName)    /M")
        push.sendPushInBackground()
        
        
        


    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //this works
//        let GameViewController = self.storyboard!.instantiateViewControllerWithIdentifier("GameViewController") as UIViewController
//        
//        self.tabBarController!.presentViewController(GameViewController, animated: true, completion: nil)
        
        
        
        //Send push notifications to the two assigned players
        
        //find target user's userobject
        //get targer's installation id, put it in PFinstallationQuery
        
        
        
        //you need to be logged in to do that
        //addImage();
        
        //loadImage();
        
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
                        nsa.targetUsername = target["username"] as! String
                        print( " \(nsa.targetUsername) is your target")
                        let targetMsg = String(nsa.targetUsername) + " is your target!"
                        let targetPlayer = target["player"]
                        nsa.targetUserId = target.objectId!
                        print("targetUserId is \(nsa.targetUserId)")
                        nsa.targetPlayerId = targetPlayer.objectId!!
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
//Setting Up Push
    
    
    //Need to have this in some VC to receive push
    func catchIt(userInfo: NSNotification){
        var notif = JSON(userInfo.valueForKey("userInfo")!)
        // Check nil and do redirect here, for example:
        if notif["type"] == "A" {
            //print("//ProfileVC:notif is \(notif)")
            nsa.targetPlayerId = String(notif["playerId"])
            print("//GameVC: targetPlayerId is \( nsa.targetPlayerId)")
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let GameViewController = self.storyboard!.instantiateViewControllerWithIdentifier("GameViewController") as UIViewController
            self.tabBarController!.presentViewController(GameViewController, animated: true, completion: nil)
        
//            dispatch_async(dispatch_get_main_queue(), {
//                self.tabBarController!.presentViewController(GameViewController, animated: true, completion: nil)
//
//            })
            
//            let gvc: UIViewController  = storyboard.instantiateViewControllerWithIdentifier("gvc") as UIViewController
//            dispatch_async(dispatch_get_main_queue(), {
//                self.navigationController!.pushViewController(gvc, animated: true)
//            })
//           print("self is\(self)")
//            self.navigationController!.presentViewController(gvc, animated: true, completion: nil)
             //performSegueWithIdentifier("toGameBegin", sender: self)
        
            //self.showViewController(gvc, sender: self)
           
        }
        else if notif["type"] == "B"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let fvc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("fvc") as UIViewController
            self.presentViewController(fvc, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {

       // self.view.backgroundColor = UIColor.whiteColor()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "catchIt:", name: "myNotif", object: nil)
        
        //Initialize data that's connected to the userCurrent method
        varInit();
    }
    
//End of Push
    
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