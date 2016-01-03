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
        print("running navigation")
        let preViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarViewController") as! UITabBarController
        
        preViewController.selectedIndex = 2;
        
        self.presentViewController(preViewController, animated: true, completion: nil)
        
    }
    @IBAction func moveToLeaderboardButton(sender: AnyObject) {
        
        print("running navigation")
        
//        let LeaderboardTableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderboardTableViewController") as UIViewController
//        self.presentViewController(LeaderboardTableViewController, animated: true, completion: nil)
    }
    @IBOutlet weak var status: UIButton!
   
    @IBOutlet weak var finishedImageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make decision of who win
        makeDecision();
        

        
    }
    
    func endGame(){
        
        print("//GameView: the game is ended")
        uploadImageToGameSession();

    }
    
    func uploadImageToGameSession(){
        //get the image
        let image = nsa.cameraImageFromMe
        let imageData = UIImageJPEGRepresentation(image, 0.9)
        let imageFile = PFFile(name:"winner.jpg", data:imageData!)
        
        // prepare to save
        nsa.currentGameSession["image"] = imageFile;
        nsa.currentGameSession.saveInBackgroundWithBlock { (result:Bool?, error: NSError?) -> Void in
            if error == nil  {
                // if upload successful, show positive result
                print("//FinishedVC:Image Uploaded")
                //I win the game
                self.addScore(nsa.myPlayer,loser: nsa.targetPlayer);
            }
            else{
                print("//FinishedVC:Image failed to upload")
                // if upload fail, show negative result
                print(error)
                self.addScore(nsa.targetPlayer,loser: nsa.myPlayer);
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
                    
                }
                else {
                    // happened when it is nil or false
                    //end The Game
                    self.endGame();
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
        self.finishedImageView.image = nsa.cameraImageFromMe
        
        
        
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
