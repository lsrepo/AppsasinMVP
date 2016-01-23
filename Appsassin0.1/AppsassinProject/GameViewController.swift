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
    
    var secondsCount = 600
    var timer = NSTimer()
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var profilePic: PFImageView!
    
        func loadImage() {
            
            let query = PFQuery(className:"Player")
            query.whereKey("objectId", equalTo:nsa.targetPlayerId)
            let _ = query.getFirstObjectInBackgroundWithBlock {  (imgObj:PFObject?, error:NSError?) -> Void in
                if error == nil {
                    print("//GameView:imgObj is\(imgObj)")
                    nsa.targetPlayer = imgObj!
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
    
    // Convert timer to format: 00:00
    func timerRun() {
        secondsCount -= 1
        var minutes = secondsCount / 60
        var seconds = secondsCount - (minutes * 60)
        
        var timerOutput = "\(minutes):\(seconds)"
        
        TimerLabel.text = "\(timerOutput)"
    }
    
    func setTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("timerRun"), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondsCount = 600
        timer.invalidate()
        setTimer()
        timerRun()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadImage();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var timerviewc = segue.destinationViewController as! CameraViewController
        timerviewc.secondsCount = self.secondsCount
    }


}
