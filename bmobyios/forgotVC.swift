//
//  forgotVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 18/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class forgotVC: UIViewController, UITextFieldDelegate {
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* PASSWORD RESET METHODS *****************************
    
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sendIntructionsBtn: UIButton!
    
    // Send instruction btn & textField method
    @IBOutlet weak var userEmailTxtF: UITextField!
    @IBAction func sendInstructionsClicked(sender: AnyObject) {
        
        PFUser.requestPasswordResetForEmailInBackground(self.userEmailTxtF.text!) { (success:Bool, error:NSError?) in
            if error == nil {
                print("email was send! Say it to \(self.userEmailTxtF.text!)")
                self.alerter("RESET PASSWORD INSTRUCTIONS", message: "An email was sent to \(self.userEmailTxtF.text!) with instructions to reset the password. Please check your mailbox.")
                
            } else {
                print(error!.localizedDescription)
                self.alerter("NO USER FOUND", message: "No user found with \(self.userEmailTxtF.text!) email adress. Please type a registered email or register by clicking SignUp button.")
            }
        }
    }
    
    
    
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
    
    func alerter(name: String, message: String){
        
        let alert = UIAlertController(title: name, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* HELPER METHODS *****************#*******************
    
    
    
    // Method to end the editing and hide the Keyboard
    func hideKeyboard(){
        
        self.view.endEditing(true)
    }
    
    
    // Method to hide the keyboard when the screen is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // Call function to hide the keyboard when touch began
        hideKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.userEmailTxtF.becomeFirstResponder()
        self.sendInstructionsClicked(self.sendIntructionsBtn)
        return true
    }
}


