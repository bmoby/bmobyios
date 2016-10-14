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

class connectionVC: UIViewController {
    
    
    
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
                if username!.characters.count < 5 {
                    print("username must be longer thant 5 chars")
                } else if password!.characters.count < 8 {
                    print("password must be longer than 8 chars")
                    
                } else {
                    // Run a spinner to show a task in progress
                    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                    spinner.startAnimating()
                    
                    // Send a request to login
                    PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                        
                        // Stop the spinner
                        spinner.stopAnimating()
                        
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
                    })
                }
                
            }
    
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
        
        if PFUser.currentUser() != nil {
            print(PFUser.currentUser()?.email)
        }
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ******************************* HELPER METHODS ************************************
    
    
    
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
