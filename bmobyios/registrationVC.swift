//
//  registrationVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registrationVC: UIViewController {
    
    var userStep1 = user()
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    // Login & password text fields ---------------------------
        @IBOutlet weak var emailTxtF: UITextField!
        @IBOutlet weak var passwordTxtF: UITextField!
        @IBOutlet weak var repeatTxtF: UITextField!
        @IBOutlet weak var phoneTxtF: UITextField!
    
    
    // Next btn action & outlet ------------------
        @IBOutlet weak var nextBtn: UIButton!
    
        @IBAction func nextClicked(sender: AnyObject) {
            
            // set the user information
            userStep1.email = emailTxtF.text
            userStep1.password = passwordTxtF.text
            userStep1.phone = phoneTxtF.text
        }

    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setValuesIfExist()
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
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** RESET FIELDS VALUES **********************************
    
    
    
    // If the user completed some info & commed back this function will display all info
    func setValuesIfExist(){
        
        if self.userStep1.email != nil {
            self.emailTxtF.text = self.userStep1.email
        }
        if self.userStep1.password != nil {
            self.passwordTxtF.text = self.userStep1.password
        }
        if self.userStep1.phone != nil {
            self.phoneTxtF.text = self.userStep1.phone
        }
        
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** PREPARE FOR SEGUE ************************************
    
    
    
    
    // This guy takes some information in the actual controller and send it to another one
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goStep2" {
            
            let registration2step :registration2stepVC = segue.destinationViewController as! registration2stepVC
                registration2step.userStep2 = self.userStep1
        }
    }
}
