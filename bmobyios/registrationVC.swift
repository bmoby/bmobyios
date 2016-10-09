//
//  registrationVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registrationVC: UIViewController {
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    // Login & password text fields ---------------------------
        @IBOutlet weak var emailTxtF: UITextField!
        @IBOutlet weak var passwordTxtF: UITextField!
        @IBOutlet weak var repeatTxtF: UITextField!
        @IBOutlet weak var phoneTxtF: UITextField!
    
    
    // Login & forgot btns actions & outlets ------------------
        @IBOutlet weak var nextBtn: UIButton!
    
        @IBAction func nextClicked(sender: AnyObject) {
            
            // ACTION HERE
        }

    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************

    
    
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
