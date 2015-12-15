//        //self.myPlayerId = "qbWwNYCi8j"
//        let pushQuery = PFQuery(className:"Player")
//        //pushQuery.whereKey("objectid", equalTo: self.myPlayerId) //need to get the coreesponding installation object
//        pushQuery.getObjectInBackgroundWithId("kNEIfo4Qub") {
//            (let targetInstallation: PFObject?, error:NSError?) -> Void in
//            if error == nil {
//                targetInstallation
//            }
//            else{
//                print("it sucks")
//            }
//
//        }


//        //difficult
//        let playerQuery = PFQuery(className:"Player");
//        playerQuery.getObjectInBackgroundWithId( "qbWwNYCi8j", block: {(
//            targetInstallation:PFObject?, error: NSError?) -> Void in
//                if error == nil {
//                    print(targetInstallation!);
//                    targetInstallation!["installation"].objectId
//                    PFPush.setq
//                }
//                else{
//                    print("it sucks")
//                }
//            })




//        let installationQuery = PFInstallation.query()
//        installationQuery!.whereKey("player", matchesQuery: playerQuery)
//        installationQuery?.getFirstObjectInBackgroundWithBlock{(
//        let targetInstallation: PFObject?, error:NSError?) -> Void in
//            if error == nil {
//                print(targetInstallation);
//            }
//            else{
//                print("it sucks")
//            }
//
//        }



//
//        // Create our Installation query
//        let pushQuery = PFInstallation.query()
//        pushQuery!.whereKey("player", equalTo: true)
//        pushQuery.wher

//        // Send push notification to query
//        let push = PFPush()
//        push.setQuery(pushQuery) // Set our Installation query
//        push.setMessage("Willie Hayes injured by own pop fly.")
//        push.sendPushInBackground()
