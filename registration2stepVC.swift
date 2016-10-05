//
//  registration2stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registration2stepVC: UIViewController {
    
    

    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    // First & last names text fields -------------------------
        @IBOutlet weak var firstNameTxtF: UITextField!
        @IBOutlet weak var lastNameTxtF: UITextField!
    
    
    // Avatar outlet ------------------------------------------
        @IBOutlet weak var avatarImg: UIImageView!

    
    // Birth date picker & text field -------------------------
        @IBOutlet weak var birthDateTxtF: UITextField!
        @IBOutlet weak var datePicker: UIDatePicker!
    
    
    // Gender selection buttons & actions ---------------------
        @IBOutlet weak var manBtn: UIButton!
        @IBAction func manClicked(sender: AnyObject) {
            // ACTION
            // ACTION
        }
    
        @IBOutlet weak var womanBtn: UIButton!
        @IBAction func womanClicked(sender: AnyObject) {
            // ACTION
            // ACTION
        }
    
        @IBOutlet weak var separatorLbl: UILabel!
    
    
    // Next button ----------------------------------------
    
        @IBOutlet weak var nextBtn: UIButton!
        @IBAction func nextClicked(sender: AnyObject) {
            // ACTION
            // ACTION
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
    



}
