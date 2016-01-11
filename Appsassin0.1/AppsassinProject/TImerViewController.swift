//
//  TImerViewController.swift
//  Appsassin0.1
//
//  Created by Catherine Hedler on 10/01/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class TImerViewController: UIViewController {
    var secondsCount = 600
    var timer = NSTimer()

    @IBOutlet weak var timerLabelTest: UILabel!
    
    // Convert timer to format: 00:00
        func timerRun() {
            secondsCount -= 1
            var minutes = secondsCount / 60
            var seconds = secondsCount - (minutes * 60)
    
            var timerOutput = "\(minutes):\(seconds)"
    
            timerLabelTest.text = "\(timerOutput)"
        }
    
        func setTimer() {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("timerRun"), userInfo: nil, repeats: true)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        timerRun()

        // Do any additional setup after loading the view.
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
