//
//  connectionVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Parse
import ParseUI
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
    
    
        // Facebook & LinkedIn  btn outlets and actions -----------
 
        @IBAction func facebookLoginBtnClicked(sender: AnyObject) {
            
            if PFUser.currentUser() == nil {
                PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email"]) { (currentUser:PFUser?, error:NSError?) in
                    if error != nil {
                    print(error!.localizedDescription)
                    }
                
                    print(currentUser)
                
                }
            }
            if FBSDKAccessToken.currentAccessToken() != nil {
                let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("Home") as! homePage
                let homepage = UINavigationController(rootViewController: protectedPage)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = protectedPage
                
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

        // Do any additional setup after loading the view.
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
        
        hideKeyboard()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
}
