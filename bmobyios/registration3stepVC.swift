//
//  registration3stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registration3stepVC: UIViewController, UITextFieldDelegate {
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    // Search bar  --------------------------------------------
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // Avatar outlet ------------------------------------------
    @IBOutlet weak var languagesCollection: UICollectionView!
    
    
    // Nationality & profession & music text fields -----------
    @IBOutlet weak var nationalityTxtF: UITextField!
    @IBOutlet weak var professionTxtF: UITextField!
    @IBOutlet weak var musicTxtF: UITextField!
    
    
    // AboutMe text view --------------------------------------
    @IBOutlet weak var aboutMeTxtV: UITextView!
    
    
    // Submit button ----------------------------------------
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBAction func submitClicked(sender: AnyObject) {
        //ACTION
    }
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
    // ******************************* DATE SELECTION ************************************
    
    
    
    // Method to change the input type of the date text field view
    
    
    // Method to show the date instantly when selecting it
    
    
    
    // -----------------------------------------------------------------------------------
    // ****************************** AVATAR SELECTION ***********************************
    
    
    
    // Method that lets the user to click on the avatar default photo and select a custom one
    
    
    // Method to hide the library ones the desired picture was selected
    

}
