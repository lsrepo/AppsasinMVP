//
//  FinishedViewController.swift
//  Appsassin0.1
//
//  Created by Pak on 17/12/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FinishedViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func moveOnButton(sender: UIButton) {
        //move to leaderboard
        print("running navigation")
        let preViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarViewController") as! UITabBarController
        
        preViewController.selectedIndex = 2;
        
        self.presentViewController(preViewController, animated: true, completion: nil)
        
    }

   
    @IBOutlet weak var moveOnButton: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var finishedImageView: UIImageView!
    @IBOutlet weak var overlayImg: UIImageView!
    @IBOutlet weak var targetImg: UIImageView!
    
    func downloadImage() {
        
        nsa.currentGameSession.fetchInBackgroundWithBlock { (gSObj:PFObject?,error:NSError? ) -> Void in
            if (error == nil){
                let userImageFile = gSObj!["image"] as? PFFile
                userImageFile!.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            self.finishedImageView.image = UIImage(data:imageData)
                            
                            self.finishedImageView.hidden = false;
                            self.overlayImg.hidden = false;
                            self.targetImg.hidden = false;
                            self.moveOnButton.hidden = false;
                            self.spinner.stopAnimating();
                        }
                    }
                }
            }
            else
            {
                print(error)
            }
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.finishedImageView.hidden = true;
        self.overlayImg.hidden = true;
        self.targetImg.hidden = true;
        self.moveOnButton.hidden = true;
        self.view.backgroundColor = UIColor.blackColor()

        // Make decision of who win
        makeDecision();
  
    }
    
    //Need to have this in some VC to receive push
    func catchIt(userInfo: NSNotification){
        var notif = JSON(userInfo.valueForKey("userInfo")!)
        // Check nil and do redirect here, for example:
        if notif["type"] == "B" {
            //Initiate change in VC
            loseGame();
        }
    }
    
    func winGame(){
        
        print("//GameView: the game is ended")
        //set isFinished
        nsa.currentGameSession["isFinished"] = true;
        nsa.currentGameSession.saveInBackground()
        
        
        //risk: perhaps image is not uploaded when view is load?
        
        
        
        //upload image
        uploadImageToGameSession();
        
        //show imageView
        self.status.text! = "Target Terminated";
        self.finishedImageView.hidden = false;
        self.overlayImg.hidden = false;
        self.targetImg.hidden = false;
        self.moveOnButton.hidden = false;
        self.finishedImageView.image = nsa.cameraImageFromMe
        
        //adjust score
        adjustScore(nsa.myPlayer,isWin:true)
        adjustScore(nsa.targetPlayer,isWin:false)
        
        

    }
    
    func adjustScore(playerObj:PFObject,isWin:Bool){
        
        
        var kills = playerObj["kills"] as! Int
        var deaths = playerObj["deaths"] as! Int
        var score = playerObj["score"] as! Int
        
        print(kills,deaths,score)
        
        
        if (isWin == true){
            //winner
            
            kills += 1;
            playerObj["kills"] = NSNumber(integer:kills)
            print("winner is \(playerObj)")

        }else {
            //loser
            deaths += 1 ;
            playerObj["deaths"] = NSNumber(integer:deaths)
            print("loser is \(playerObj)")
        }
        //base score : 500, win/ lose : +/- 50
        score = 500 + (kills)*50 - (deaths)*50
        playerObj["score"] = NSNumber(integer:score)
        playerObj.saveInBackgroundWithBlock { (result:Bool, error:NSError?) -> Void in
            print("adjust score done",result)
        }
        
        
       
        
        
    }
    
    func loseGame(){
        
        self.status.text! = "You're terminated!";
        downloadImage();
        
        
    }
    
 
    
    func uploadImageToGameSession(){
        //get the image
        let image = nsa.cameraImageFromMe
        let imageData = UIImageJPEGRepresentation(image, 0.9)
        let imageFile = PFFile(name:"winner.jpg", data:imageData!)
        
        // prepare to save
        nsa.currentGameSession["image"] = imageFile;
        
        // try to deny target to access the game object
        //nsa.currentGameSession.ACL!.setWriteAccess(false, forUserId: nsa.targetUserId)
      
        print("nsa.targetUserId\(nsa.targetUserId)")
        // Implement it
        nsa.currentGameSession.saveInBackgroundWithBlock { (result:Bool?, error: NSError?) -> Void in
            if error == nil  {
                //upload successful
                let tmpDate =  NSDate()
                print(tmpDate,"//FinishedVC:Image Uploaded")
                
                //send notification to target
                nsa.pushAssignments(nsa.targetPlayerId, targetedName: nsa.myUsername,type: "B")
                
            }
            else{
                print("//FinishedVC:Image failed to upload",error)
            }
        }
    }
    
    func addScore(winner: PFObject,loser: PFObject){
        
        
    }
    
    
    func makeDecision(){
        // check game status. ie.e check if player is directed from push notif
        //  upload the picture
        
        nsa.currentGameSession.fetchInBackgroundWithBlock {
            (gameSessionObj: PFObject?, error: NSError?) -> Void in
            if error == nil  {
                if (gameSessionObj!["isFinished"] === true){
                    // I lose, wait!
                    if (nsa.playerStatus == "Loser")
                    {
                       self.loseGame();
                    }
                    
                }
                else {
                    // happened when it is nil or false
                    // I win --> end The Game
                    self.winGame();
                }
            } else {
                print("\(error!) ")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "catchIt:", name: "myNotif", object: nil)

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
