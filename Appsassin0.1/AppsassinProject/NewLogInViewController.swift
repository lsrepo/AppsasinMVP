

import UIKit
import Parse

class NewLogInViewController: UIViewController {
    
    func registerSession(){
        // Associate the device with User class and associate the device with Player class
        let installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
        installation["player"] = PFUser.currentUser()!["player"]
        //print("//From Login:Installation is set to \(installation["player"])");
        installation.saveInBackground()
        
        
        // Associate User class with installationID
        PFUser.currentUser()!["installation"] = installation
        
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

                    } else {


                        //Associate player and username if you're newly registered
                        //create a playerClass
                        let playerClass = PFObject(className:"Player")
                        playerClass["username"] = user.username
                        playerClass["installation"] = PFInstallation.currentInstallation()
                        playerClass.ACL?.publicWriteAccess = true
                        playerClass.saveInBackgroundWithBlock({ (tf:Bool, error:NSError?) -> Void in
                            //Sign in
                            
                            PFUser.logInWithUsernameInBackground(self.username.text!, password:"password", block: { (result:PFUser?, error:NSError?) -> Void in
                                //Associate player with user
                                PFUser.currentUser()?["player"] = playerClass;
                                PFUser.currentUser()?.saveInBackgroundWithBlock({ (tf:Bool, error:NSError?) -> Void in
                                    //Log user in
                                    self.registerSession();
                                    self.performSegueWithIdentifier("whatsup", sender: self)
                                })
                            })
 
                        })
  
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
}