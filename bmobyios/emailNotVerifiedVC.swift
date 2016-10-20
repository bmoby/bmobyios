//
//  emailNotVerifiedVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 14/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class emailNotVerifiedVC: UIViewController {
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* EMAIL VERIFY METHODS *******************************
    
    
    
    
    // This functions change the value of email of the user and parse resend a confirmation mail
    @IBAction func resendEmailVerifClicked(sender: AnyObject) {
        
        let email = PFUser.currentUser()!.email
        PFUser.currentUser()!.setValue(email, forKey: "email")
        PFUser.currentUser()!.saveInBackground()
        
        self.alerter("EMAIL RESEND", message: "The email verification message has been resent to your email \(PFUser.currentUser()!.email)")
    }
    
    // New email text field if and action to send an email to the email entered in that TextField
    @IBOutlet weak var newEmailTxtF: UITextField!
    @IBAction func sendVerifEmailToNewEmailBtnClicked(sender: AnyObject) {
        
        let email = self.newEmailTxtF.text
        
        
        if !self.restrictEmail(email!){
            self.alerter("EMAIL INCORRECT", message: "Please enter a valid email adress!")
        } else if (self.userExists(email!)) {
            self.alerter("USER EXISTS", message: "A user with \(email) is already registered. If this is your email please reset the password and if not please register or connect with facebook.")
            
        } else {
            PFUser.currentUser()!.setValue(email, forKey: "email")
            PFUser.currentUser()!.saveInBackground()
        }
        
        
    }

    // If user have already verified the email this button takes him to the real home page
    @IBAction func alreadyVerifiedBtnClicked(sender: AnyObject) {
        
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (object:PFObject?, error:NSError?) in
            let emailVerified = PFUser.currentUser()?.objectForKey("emailVerified")?.boolValue
            
            if emailVerified == true {
                
                let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                let navigation = UINavigationController(rootViewController: viewController)
                self.presentViewController(navigation, animated: true, completion: nil)
            } else {
                
                self.alerter("EMAIL NOT VERIFIED", message: "Please verify your email and try again.")
            }
        })
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //*********************************** HELPER METHODS *********************************
    
    
    
    func userExists(email: String) -> Bool{
        let query = PFUser.query()
        var response : Bool = Bool()
        query?.whereKey("email", equalTo: email)
        query?.getFirstObjectInBackgroundWithBlock({ (object:PFObject?, error:NSError?) in
            if error == nil {
                response = true
            } else {
                response = false
            }
        })
        
        return response
    }
    
    
    // Log out button
    @IBAction func logOutClicked(sender: AnyObject) {
        
        PFUser.logOut()
        print("User loged out with success")
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("loginPage")
            let navigation = UINavigationController(rootViewController: viewController)
            self.presentViewController(navigation, animated: true, completion: nil)
        })
    }
    
    // Email restriction method
    func restrictEmail(email: String) -> Bool{
        
        let regex = "[A-Z0-9a-z._-]{3}+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2}"
        let range = email.rangeOfString(regex, options: .RegularExpressionSearch)
        if range != nil {
            return true
        }else {
            return false
        }
    }
    
    
    // Reusebal alert method with message and title params
    func alerter(name: String, message: String){
        
        let alert = UIAlertController(title: name, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // Method to end the editing and hide the Keyboard
    func hideKeyboard(){
        
        self.view.endEditing(true)
    }
    
    
    // Method to hide the keyboard when the screen is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // Call function to hide the keyboard when touch began
        hideKeyboard()
    }
}
