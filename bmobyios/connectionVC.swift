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
    
    
        // Facebook & Twitter  btn outlets and actions -----------
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
                            let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! homePage
                            let homepages = UINavigationController(rootViewController: protectedPage)
                            self.navigationController?.presentViewController(homepages, animated: true, completion: nil)
                        }
                    }
                }
                
                // If he/she is connected redirect them to the home page or what ever
                else {
                    
                    // Creating copy of the nextviewcontroller and push to it vie Navigation
                    let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! homePage
                    let homepages = UINavigationController(rootViewController: protectedPage)
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                    // set the rootView to the home page or whatever if the user is connected
                    appDelegate.window?.rootViewController = homepages
                }
            }
    
    
        // Login & password text fields ---------------------------
            @IBOutlet weak var loginTxtF: UITextField!
            @IBOutlet weak var passwordTxtF: UITextField!
    
    
        // Login & forgot btns actions & outlets ------------------
            @IBOutlet weak var loginBtn: UIButton!
            @IBAction func loginClicked(sender: AnyObject) {
                
                // ACTION
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
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if (PFUser.currentUser() != nil) {
            
            let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! homePage
            let homepages = UINavigationController(rootViewController: protectedPage)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            // set the rootView to the home page or whatever if the user is connected
            appDelegate.window?.rootViewController = homepages
            self.navigationController!.presentViewController(homepages, animated: true, completion: nil)
        }

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
