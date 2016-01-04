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
    
    func winGame(){
        
        print("//GameView: the game is ended")
        //set isFinished
        nsa.currentGameSession["isFinished"] = true;
        nsa.currentGameSession.saveInBackground()
        
        //upload image
        uploadImageToGameSession();
        
        //send notification to target
        nsa.pushAssignments(nsa.targetPlayerId, targetedName: nsa.myUsername,type: "B")
        
        //show imageView
        self.status.text! = "Target Terminated";
        self.finishedImageView.hidden = false;
        self.overlayImg.hidden = false;
        self.targetImg.hidden = false;
        self.moveOnButton.hidden = false;
        self.finishedImageView.image = nsa.cameraImageFromMe

    }
    
    func loseGame(){
        
    }
    
 
    
    func uploadImageToGameSession(){
        //get the image
        let image = nsa.cameraImageFromMe
        let imageData = UIImageJPEGRepresentation(image, 0.9)
        let imageFile = PFFile(name:"winner.jpg", data:imageData!)
        
        // prepare to save
        nsa.currentGameSession["image"] = imageFile;
        // deny target to access the game object
        nsa.currentGameSession.ACL!.setWriteAccess(false, forUserId: nsa.targetUserId)
        nsa.currentGameSession["test"] = " baby"
        print("nsa.targetUserId\(nsa.targetUserId)")
        // Implement it
        nsa.currentGameSession.saveInBackgroundWithBlock { (result:Bool?, error: NSError?) -> Void in
            if error == nil  {
                //upload successful
                print("//FinishedVC:Image Uploaded")
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
                    // I lose
                    self.loseGame();
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
