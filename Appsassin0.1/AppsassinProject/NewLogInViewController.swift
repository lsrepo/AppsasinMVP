

import UIKit
import Parse


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
    var currentGameSession = PFObject(className:"Game")
    var myPlayer = PFObject(className:"Player")
    var targetPlayer = PFObject(className:"Player")
    
    
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
                //print("-\(playerObj)")
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


class NewLogInViewController: UIViewController {
    
    func registerSession(){
        // Associate the device with User class and associate the device with Player class
        let installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
        installation["player"] = PFUser.currentUser()!["player"]
        //print("//From Login:Installation is set to \(installation["player"])");
        installation.saveInBackground()
        
        //Setup Profile picture for next view
        let preparePlayerId = PFUser.currentUser()!["player"]
        
        nsa.myPlayerId = preparePlayerId.objectId!!
        
        
    }
    
   
    @IBOutlet weak var username: UITextField!
    
    
   // @IBOutlet var errorLabel: UILabel!
    
    @IBAction func signUp(sender: AnyObject) {
    
    
        PFUser.logInWithUsernameInBackground(username.text!, password:"password") {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                
                var user = PFUser()
                user.username = self.username.text!
                user.password = "password"
                
                user.signUpInBackgroundWithBlock {
                    (succeeded, error) -> Void in
                    
                    if let error = error {
                        
                        let errorString = error.userInfo["error"]! as! String
                        
                        //self.errorLabel.text = "Error: " + errorString
                        
                    } else {
                        
                        print("Signed Up")
                        //                      self.performSegueWithIdentifier("whatsup", sender: self)
                        
                        //Associate player and username if you're newly registered
                        let playerClass = PFObject(className:"Player")
                        playerClass["username"] = user.username
                        print(playerClass["username"])
                        playerClass.saveInBackground()
                        
                    }
                    
                    
                }
                
            } else {
                
                print("Logged In")
                self.registerSession();
                self.performSegueWithIdentifier("whatsup", sender: self)
                
                
            }
            
            
        }
        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.hidden = true
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser()?.username != nil {
            
            self.performSegueWithIdentifier("whatsup", sender: self)
            self.registerSession();
            print("//From Login:Already logged in")
        }
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    //
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
}