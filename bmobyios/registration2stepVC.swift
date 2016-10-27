//
//  registration2stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registration2stepVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userStep2 = user()
    
    
    
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
            
        self.manBtn.backgroundColor = UIColor.cyanColor()
        self.womanBtn.backgroundColor = UIColor.grayColor()
        self.userStep2.gender = "man"
    }

    @IBOutlet weak var womanBtn: UIButton!
    @IBAction func womanClicked(sender: AnyObject) {
            
        self.womanBtn.backgroundColor = UIColor.purpleColor()
        self.manBtn.backgroundColor = UIColor.grayColor()
        self.userStep2.gender = "woman"
    }
    
    @IBOutlet weak var separatorLbl: UILabel!
    
    
    // Next & back buttons ------------------------------------
    @IBOutlet weak var nextBtn: UIButton!
    @IBAction func nextClicked(sender: AnyObject) {
            
        if self.firstNameTxtF.text! == "" || self.lastNameTxtF.text! == "" || self.birthDateTxtF.text! == "" {
            alerter("Empty fields", message: "Pleas fil all fields.")
        }else if (self.userStep2.gender == nil){
            alerter("GENDER IS NOT SELECTED", message: "Please select a gender.")
        } else {
            
            self.userStep2.firstName = self.firstNameTxtF.text
            self.userStep2.lastName = self.lastNameTxtF.text
            self.userStep2.avatar = self.avatarImg
            self.userStep2.birthDate = self.birthDateTxtF.text
            self.performSegueWithIdentifier("goStep3", sender: nil)
        }
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backClicked(sender: AnyObject) {
            
        self.userStep2.firstName = self.firstNameTxtF.text
        self.userStep2.lastName = self.lastNameTxtF.text
        self.userStep2.avatar = self.avatarImg
        self.userStep2.birthDate = self.birthDateTxtF.text
        self.performSegueWithIdentifier("backStep1", sender: nil)
    }
    
    
    @IBOutlet weak var saveBnt: UIButton!
    @IBAction func saveBtnClicked(sender: AnyObject) {
        PFUser.currentUser()?.setValue(self.firstNameTxtF.text , forKey: "firstName")
        PFUser.currentUser()?.setValue(self.lastNameTxtF.text , forKey: "lastName")
        PFUser.currentUser()?.setValue(self.birthDateTxtF.text , forKey: "birthDate")
        PFUser.currentUser()?.setValue(self.userStep2.gender, forKey: "gender")
        
        let image = UIImageJPEGRepresentation(self.avatarImg.image!, 0.5)
        let imageFile = PFFile(name: "img1", data: image!)
        PFUser.currentUser()?.setValue(imageFile, forKey: "avatar")
        
        PFUser.currentUser()?.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) in
            if success {
                print("user updated")
            }
        })
        let story = UIStoryboard(name: "profileSB", bundle: nil)
        let profileInfoEdit = story.instantiateViewControllerWithIdentifier("editProf") as! editProfile
        self.presentViewController(profileInfoEdit, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func cancelBtnClicked(sender: AnyObject) {
        let story = UIStoryboard(name: "profileSB", bundle: nil)
        let profileInfoEdit = story.instantiateViewControllerWithIdentifier("editProf") as! editProfile
        self.presentViewController(profileInfoEdit, animated: true, completion: nil)
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Avatar picker & photo corner settings
        self.avatarImg.layer.cornerRadius = self.avatarImg.frame.size.width / 2
        self.avatarImg.layer.masksToBounds = true
        self.navigationController?.navigationBar.hidden = true
        
        self.firstNameTxtF.delegate = self
        self.lastNameTxtF.delegate = self
        
        if PFUser.currentUser() == nil {
            self.saveBnt.hidden = true
            self.cancelBtn.hidden = true
            self.titleLbl.text = "Profile"
            setAvatar()
            setValuesIfExist()
        } else {
            self.nextBtn.hidden = true
            self.backBtn.hidden = true
            self.titleLbl.text = "Edit profile"
            setAvatar()
            setCurrentUserInfo()
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** RESET FIELDS VALUES **********************************
    
    
    
    // If the user completed some info & commed back this function will display all info
    func setValuesIfExist(){
        
        if self.userStep2.firstName != nil {
            self.firstNameTxtF.text = self.userStep2.firstName
        }
        if self.userStep2.lastName != nil {
            self.lastNameTxtF.text = self.userStep2.lastName
        }
        if self.userStep2.avatar.image != nil {
            self.avatarImg.image = self.userStep2.avatar.image
        }
        if self.userStep2.birthDate != nil {
            self.birthDateTxtF.text = self.userStep2.birthDate
        }
        if self.userStep2.gender != nil {
            if self.userStep2.gender == "man" {
                self.manBtn.backgroundColor = UIColor.cyanColor()
                self.womanBtn.backgroundColor = UIColor.grayColor()
                self.userStep2.gender = "man"
            } else {
                self.womanBtn.backgroundColor = UIColor.purpleColor()
                self.manBtn.backgroundColor = UIColor.grayColor()
                self.userStep2.gender = "woman"
            }
        }
    }
    
    // Ser current user if he commes here to edit his/her info
    func setCurrentUserInfo() {
        self.firstNameTxtF.text = PFUser.currentUser()?.valueForKey("firstName") as? String
        self.lastNameTxtF.text = PFUser.currentUser()?.valueForKey("lastName") as? String
        self.birthDateTxtF.text = PFUser.currentUser()?.valueForKey("birthDate") as? String
        let ava = PFUser.currentUser()!.objectForKey("avatar") as! PFFile
        ava.getDataInBackgroundWithBlock { (data:NSData?, error:NSError?) in
            if error == nil {
                self.avatarImg.image = UIImage(data: data!)
            } else {
                print(error!.localizedDescription)
            }
        }
        if PFUser.currentUser()?.valueForKey("gender") as! String == "man" {
            self.manBtn.backgroundColor = UIColor.cyanColor()
            self.womanBtn.backgroundColor = UIColor.grayColor()
            self.userStep2.gender = "man"
        } else {
            self.womanBtn.backgroundColor = UIColor.purpleColor()
            self.manBtn.backgroundColor = UIColor.grayColor()
            self.userStep2.gender = "woman"
        }
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
    
    func alerter(name: String, message: String){
        
        let alert = UIAlertController(title: name, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.firstNameTxtF {
            self.lastNameTxtF.becomeFirstResponder()
            return true 
        } else {
            return true
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ******************************* DATE SELECTION ************************************
    
    
    
    // Method to change the input type of the date text field view
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Declaring the variables
        let datePicker = UIDatePicker()
        let date = NSDateComponents()
            date.year = 1998
            date.month = 01
            date.day = 01

        let calendar = NSCalendar.currentCalendar()
        let minDate :NSDate = calendar.dateFromComponents(date)!
        
        // Setting the values
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
    
    
    
    // -----------------------------------------------------------------------------------
    // ****************************** AVATAR SELECTION ***********************************
    
    
    
    // Avatar set func
    func setAvatar(){
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.addImg(_:)))
            imageTap.numberOfTapsRequired = 1
        self.avatarImg.userInteractionEnabled = true
        self.avatarImg.addGestureRecognizer(imageTap)
    }
    
    // Method that lets the user to click on the avatar default photo and select a custom one
    func addImg(recognizer :UITapGestureRecognizer){
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // Method to hide the library ones the desired picture was selected
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.avatarImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        self.userStep2.avatar.image = info[UIImagePickerControllerEditedImage] as? UIImage
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** PREPARE FOR SEGUE ************************************
    
    
    
    // This guy takes some information in the actual controller and send it to another one
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "backStep1" {
            
            let registration :registrationVC = segue.destinationViewController as! registrationVC
                registration.userStep1 = self.userStep2
        } else if segue.identifier == "goStep3" {
            
            let registration3 :registration3stepVC = segue.destinationViewController as! registration3stepVC
                registration3.userStep3 = self.userStep2
        }
    }
}
