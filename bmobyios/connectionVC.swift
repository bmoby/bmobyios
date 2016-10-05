//
//  connectionVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Parse


class connectionVC: UIViewController {
    
    // -----------------------------------------------------------------------------------
    //**************************** OUTLETS & ACTIONS *************************************
    
    
    
        @IBOutlet weak var titleLbl: UILabel!
    
        // SignUp btn outlet and action ---------------------------
            @IBOutlet weak var signupBtn: UIButton!
    
            @IBAction func signupClicked(sender: AnyObject) {
                
                // ACTION HERE
            }
    
    
        // Facebook & LinkedIn  btn outlets and actions -----------
            @IBOutlet weak var facebookConnectionBtn: UIButton!
            @IBAction func facebookConnectionClicked(sender: AnyObject) {
                
                // ACTION HERE
            }
    
            @IBOutlet weak var linkedInConnectionBtn: UIButton!
            @IBAction func linkedInConnectionClicked(sender: AnyObject) {
                
                // ACTION HERE
            }
    
    
        // Login & password text fields ---------------------------
            @IBOutlet weak var loginTxtF: UITextField!
            @IBOutlet weak var passwordTxtF: UITextField!
    
    
        // Login & forgot btns actions & outlets ------------------
            @IBOutlet weak var loginBtn: UIButton!
            @IBAction func loginClicked(sender: AnyObject) {
                
                // ACTION HERE
            }
    
            @IBOutlet weak var forgotBtn: UIButton!
            @IBAction func forgotClicked(sender: AnyObject) {
                
                // ACTION HERE
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
