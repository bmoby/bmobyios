//
//  registration2stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registration2stepVC: UIViewController, UITextFieldDelegate {
    
    

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
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Declaring the variables
        let datePicker = UIDatePicker()
        let date = NSDateComponents()
        let calendar = NSCalendar.currentCalendar()
        let minDate :NSDate = calendar.dateFromComponents(date)!
        
        // Setting the values
        date.year = 1998
        date.month = 01
        date.day = 01
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.date = minDate
        
        // Setting the inputView of the date picker and calling another method "showDate" to update...
        self.birthDateTxtF.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.showDate(_:)), forControlEvents: .ValueChanged)
    }
    
    
    // Method to show the date instantly when selecting it
    func showDate(sender: UIDatePicker){
        
        let dateConverter = NSDateFormatter()
        dateConverter.dateStyle = .LongStyle
        self.birthDateTxtF.text = dateConverter.stringFromDate(sender.date)
    }
    
    
    
    
    
    
    
}
