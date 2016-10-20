//
//  registrationVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registrationVC: UIViewController, UITextFieldDelegate {
    
    var userStep1 = user()
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    // Login & password text fields ---------------------------
        @IBOutlet weak var emailTxtF: UITextField!
        @IBOutlet weak var passwordTxtF: UITextField!
        @IBOutlet weak var repeatTxtF: UITextField!
        @IBOutlet weak var phoneTxtF: UITextField!
    
    
    // Next btn action & outlet -------------------------------
        @IBOutlet weak var nextBtn: UIButton!
    
        @IBAction func nextClicked(sender: AnyObject) {
            
            let query = PFUser.query()!.whereKey("email", equalTo: self.emailTxtF.text!)
            query.getFirstObjectInBackgroundWithBlock { (object:PFObject?, error:NSError?) in
                if error == nil {
                    
                    self.alerter("USER EXISTS", message: "There is already a user registered with \(self.emailTxtF.text) if you forgot your password send a request by clicking on forgot button.")
                } else {
                    
                    if !self.restrictEmail(self.emailTxtF.text!) || self.emailTxtF.text == ""{
                        
                        self.alerter("Incorrect Email", message: "Please enter a correct email.")
                    } else if self.passwordTxtF!.text!.characters.count < 8 || self.passwordTxtF.text != self.repeatTxtF.text || self.passwordTxtF.text == ""{
                        
                        self.alerter("Incorrect Password", message: "Password most contain at least 8 characters and repeat password most match with password.")
                    } else {
                        
                        // set the user information
                        self.userStep1.email = self.emailTxtF.text
                        self.userStep1.password = self.passwordTxtF.text
                        self.userStep1.phone = self.phoneTxtF.text
                        self.performSegueWithIdentifier("goStep2", sender: nil)
                    }
                }
            }
        }
    
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setValuesIfExist()
        self.navigationController?.navigationBar.hidden = true
        
        self.emailTxtF.delegate = self
        self.passwordTxtF.delegate = self
        self.repeatTxtF.delegate = self
        self.phoneTxtF.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ******************************* HELPER METHODS ************************************
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailTxtF {
            
            self.passwordTxtF.becomeFirstResponder()
            
            return true
        } else if (textField == self.passwordTxtF) {
           
            self.repeatTxtF.becomeFirstResponder()
            return true
        } else {
            self.phoneTxtF.becomeFirstResponder()
            return true
        }
    }

    
    // Method to end the editing and hide the Keyboard
    func hideKeyboard(){
        
        self.view.endEditing(true)
    }
    
    
    // Method to hide the keyboard when the screen is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        hideKeyboard()
    }
    
    func alerter(name: String, message: String){
        
        let alert = UIAlertController(title: name, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    // Function to let user inter a correct email adresse
    func restrictEmail(email: String) -> Bool{
        
        let regex = "[A-Z0-9a-z._-]{3}+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2}"
        let range = email.rangeOfString(regex, options: .RegularExpressionSearch)
        if range != nil {
            return true
        }else {
            return false
        }
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
            self.repeatTxtF.text = self.userStep1.password
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
