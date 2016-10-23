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
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    // Next btn action & outlet -------------------------------
    @IBOutlet weak var nextBtn: UIButton!
    @IBAction func nextClicked(sender: AnyObject) {
        
            let query = PFUser.query()!.whereKey("email", equalTo: self.emailTxtF.text!)
            query.getFirstObjectInBackgroundWithBlock { (object:PFObject?, error:NSError?) in
                if error == nil {
                    
                    self.alerter("USER EXISTS", message: "There is already a user registered with \(self.emailTxtF.text) if you forgot your password send a request by clicking on forgot button.")
                } else {
                    
                    if !self.restrictEmail(self.emailTxtF.text!) || self.emailTxtF.text == ""{
                        
                        self.alerter("INCORRECT EMAIL", message: "Please enter a correct email.")
                    } else if self.passwordTxtF!.text!.characters.count < 8 || self.passwordTxtF.text != self.repeatTxtF.text || self.passwordTxtF.text == ""{
                        
                        self.alerter("INCORRECT PASSWORD", message: "Password most contain at least 8 characters and repeat password most match with password.")
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
    
    
    // Save btn when user comes to edit his/her profile
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func saveBtnClicked(sender: AnyObject) {
        
        if passwordTxtF.text != repeatTxtF.text {
            alerter("INCORRECT PASSWORD", message: "Password must to match with repeat password.")
        } else if !self.restrictEmail(self.emailTxtF.text!) || self.emailTxtF.text == "" {
            self.alerter("INCORRECT EMAIL", message: "Please enter a correct email.")
        } else if self.passwordTxtF!.text! != ""{
            if self.passwordTxtF!.text!.characters.count < 8 {
                self.alerter("INCORRECT PASSWORD", message: "Password most contain at least 8 characters.")
            } else {
            print("password ok")
            }
        }
            if (PFUser.currentUser()?.valueForKey("email") as? String != self.emailTxtF.text){
                PFUser.currentUser()?.setValue(self.emailTxtF.text , forKey: "email")
            }
            if self.passwordTxtF.text != nil {
                PFUser.currentUser()?.setValue(self.passwordTxtF.text , forKey: "password")
            }
            PFUser.currentUser()?.setValue(self.phoneTxtF.text , forKey: "phone")
            PFUser.currentUser()?.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) in
                if success {
                    print("user updated")
                }
            })

            // Redirect after restrictions varnings if every thing is ok
            let story = UIStoryboard(name: "profileSB", bundle: nil)
            let nextController = story.instantiateViewControllerWithIdentifier("editProf") as! editProfile
            self.presentViewController(nextController, animated: true, completion: nil)
        
    }
    
    // Back btn when user edit his/her profile
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backBtnClicked(sender: AnyObject) {
        let story = UIStoryboard(name: "profileSB", bundle: nil)
        let profileInfoEdit = story.instantiateViewControllerWithIdentifier("editProf") as! editProfile
        self.presentViewController(profileInfoEdit, animated: true, completion: nil)
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.hidden = true
        
        self.emailTxtF.delegate = self
        self.passwordTxtF.delegate = self
        self.repeatTxtF.delegate = self
        self.phoneTxtF.delegate = self
        
        if PFUser.currentUser() == nil {
            setValuesIfExist()
            self.saveBtn.hidden = true
            self.backBtn.hidden = true
            self.titleLbl.text = "Registration"
        } else {
            self.nextBtn.hidden = true
            self.cancelBtn.hidden = true
            self.titleLbl.text = "Edit profile"
            setValuesOfCurrentUser()
        }
        
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
    
    // Alerter helper method to alert
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
    
    // Method that sets the values of current user if there is a connection
    func setValuesOfCurrentUser(){
        self.emailTxtF.text = PFUser.currentUser()!.email
        self.phoneTxtF.text = PFUser.currentUser()!.valueForKey("phone") as? String
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
