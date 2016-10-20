//
//  connectionVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import mailgun

class connectionVC: UIViewController, UITextFieldDelegate {
    
    
    
    // -----------------------------------------------------------------------------------
    //**************************** OUTLETS & ACTIONS *************************************
    
    
    
        @IBOutlet weak var titleLbl: UILabel!
    
            // SignUp btn outlet and action ---------------------------
            @IBOutlet weak var signupBtn: UIButton!
            @IBAction func signupClicked(sender: AnyObject) {
                
                // ACTION
            }
    
    
            // Facebook  btn outlets and actions ----------------------
            @IBAction func facebookLoginBtnClicked(sender: AnyObject) {
                
                // Check if the current user is signed in or not to act
                if PFUser.currentUser() == nil {
                    
                    // If he/she is not yet connected loginwith facebook and request thous informations
                    PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"]) {
                        
                        (currentUser:PFUser?, error:NSError?) in
                        // If error print the error
                        if error != nil {
                            
                            print(error!.localizedDescription)
                        }else{
                            if (PFUser.currentUser() != nil) {
                                
                                print("User loged in with success")
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                                    let navigation = UINavigationController(rootViewController: viewController)
                                    self.presentViewController(navigation, animated: true, completion: nil)
                                })
                            }
                        }
                    }
                }
                
                // If he/she is connected redirect them to the home page or what ever
                else {
                    
                    if (PFUser.currentUser() != nil) {
                        
                        print("User loged in with success")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                            let navigation = UINavigationController(rootViewController: viewController)

                            self.presentViewController(navigation, animated: true, completion: nil)
                        })
                    }
                }
            }

    
            // Login & password text fields ---------------------------
            @IBOutlet weak var loginTxtF: UITextField!
            @IBOutlet weak var passwordTxtF: UITextField!
    
    
            // Login & forgot btns actions & outlets ------------------
            @IBOutlet weak var loginBtn: UIButton!
            @IBAction func loginClicked(sender: AnyObject) {
                
                let username = self.loginTxtF.text
                let password = self.passwordTxtF.text
                
                // Validate the text fields
                if (!restrictEmail(self.loginTxtF.text!) || self.loginTxtF.text == "") && (password!.characters.count < 8 || self.passwordTxtF.text == ""){
                    
                    self.alerter("Incorrect Email and Password", message: "Please enter a correct email and enter a password longer or equal to 8 characters.")
                    return
                    
                } else if password!.characters.count < 8 || self.passwordTxtF.text == ""{
                     self.alerter("Incorrect Password", message: "Password most contain at least 8 characters.")
                    return
                } else if !restrictEmail(self.loginTxtF.text!) || self.loginTxtF.text == ""{
                    self.alerter("Incorrect Email", message: "Please enter a correct email.")
                    return

                
                } else {
                    // Run a spinner to show a task in progress
                    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                    spinner.startAnimating()
                    
                    // Send a request to login
                    PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                        
                    if error == nil {
                        // Stop the spinner
                        spinner.stopAnimating()
                        if (user?.valueForKey("emailVerified")?.boolValue == true){
                            if ((user) != nil) {
                                print("User loged in with success")
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                                    let navigation = UINavigationController(rootViewController: viewController)
                                    self.presentViewController(navigation, animated: true, completion: nil)
                                })
                                
                            } else {
                                print(error!.localizedDescription)
                            }

                        } else {
                            print("please verify your email and click the button")
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("NotVerified")
                                let navigation = UINavigationController(rootViewController: viewController)
                                self.presentViewController(navigation, animated: true, completion: nil)
                            })
                        }
                    } else {
                        self.alerter("USER NOT FOUD", message: "There is no user \(self.loginTxtF.text) in our DB or the password did not match! Please try again or register.")
                    }
                })
            }
        }
    
        // Outlet and action of forgot button
        @IBOutlet weak var forgotBtn: UIButton!
        @IBAction func forgotClicked(sender: AnyObject) {
            
            // ACTION
        }
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** DEFAULT ACTIONS *************************************


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.reloadInputViews()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = true
        self.loginTxtF.delegate = self
        self.passwordTxtF.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ******************************* HELPER METHODS ************************************
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.loginTxtF {
            
            self.passwordTxtF.becomeFirstResponder()
            
            return true
        } else {
            textField.becomeFirstResponder()
            performAction()
            return false
        }
    }
    
    func performAction() {
        self.loginClicked(self.loginBtn)
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
    
    func alerter(name: String, message: String){
        
        let alert = UIAlertController(title: name, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // Email restriction function
    func restrictEmail(email: String) -> Bool{
        
        let regex = "[A-Z0-9a-z._-]{3}+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2}"
        let range = email.rangeOfString(regex, options: .RegularExpressionSearch)
        if range != nil {
            return true
        }else {
            return false
        }
    }
}
