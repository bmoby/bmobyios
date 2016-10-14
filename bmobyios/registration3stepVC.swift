//
//  registration3stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registration3stepVC: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    var scrollViewHeight :CGFloat = 0
    var keyboard = CGRect()
    var userStep3 = user()
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    // Avatar outlet ------------------------------------------
    @IBOutlet weak var languagesCollection: UICollectionView!
    
    
    // Nationality & profession & music text fields -----------
    @IBOutlet weak var nationalityTxtF: UITextField!
    @IBOutlet weak var professionTxtF: UITextField!
    @IBOutlet weak var musicTxtF: UITextField!
    
    
    // AboutMe text view --------------------------------------
    @IBOutlet weak var aboutMeTxtV: UITextView!
    
    
    // Submit & back  button ----------------------------------
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBAction func submitClicked(sender: AnyObject) {
        
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
        self.userStep3.music = self.musicTxtF.text
        self.userStep3.aboutMe = self.aboutMeTxtV.text
        
        // Saving all in DB
        self.userStep3.save()
        
        
    }
    
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backClicked(sender: AnyObject) {
        
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
        self.userStep3.music = self.musicTxtF.text
        self.userStep3.aboutMe = self.aboutMeTxtV.text
    }
    
    // Scroll view
    
    @IBOutlet weak var scrollRegistration3step: UIScrollView!
    
    // Add a language btn
    @IBAction func addLanguageClicked(sender: AnyObject) {
        
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
        self.userStep3.music = self.musicTxtF.text
        self.userStep3.aboutMe = self.aboutMeTxtV.text
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.languagesCollection.delegate = self
        self.languagesCollection.dataSource = self
        
        // Setting the about me text view tap gesture recognizer
        let tapOnTxtView = UITapGestureRecognizer(target: self, action: #selector(registration3stepVC.setTextView(_:)))
        tapOnTxtView.numberOfTapsRequired = 1
        
        self.aboutMeTxtV.userInteractionEnabled = true
        self.aboutMeTxtV.addGestureRecognizer(tapOnTxtView)
        
        // Hide keyboard on tap on scrollView with tap gesture recognizer
        let tapOnScroll = UITapGestureRecognizer(target: self, action: #selector(registration3stepVC.scrollTap(_:)))
        tapOnScroll.numberOfTapsRequired = 1
        self.scrollRegistration3step.userInteractionEnabled = true
        self.scrollRegistration3step.addGestureRecognizer(tapOnScroll)
        
        // Setting the frame to enable scroll on keyboard show
        self.scrollRegistration3step.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.scrollRegistration3step.contentSize.height = self.view.frame.height
        self.scrollViewHeight = self.view.frame.height
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(registration3stepVC.setScrollHeightOnShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
     
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(registration3stepVC.setScrollHeightOnHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // Show the existing values in text fields if exist a record in the user variable
        setValuesIfExist()
        
     }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** RESET FIELDS VALUES **********************************
    
    
    
    // If the user completed some info & commed back this function will display all info
    func setValuesIfExist(){
        
        if self.userStep3.firstName != nil {
            self.nationalityTxtF.text = self.userStep3.nationality
        }
        if self.userStep3.lastName != nil {
            self.professionTxtF.text = self.userStep3.profession
        }
        if self.userStep3.avatar != nil {
            self.musicTxtF.text = self.userStep3.music
        }
        if self.userStep3.birthDate != nil {
            self.aboutMeTxtV.text = self.userStep3.aboutMe
        }
        if self.userStep3.languages.count > 0 {
            languagesCollection.reloadData()
            
        }
    }

    
    
    // -----------------------------------------------------------------------------------
    // ******************************* HELPER METHODS ************************************
    
    
    // Method for set the scroll height on keyboard show
    func setScrollHeightOnShow(notification :NSNotification){
        
        keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]!.CGRectValue())!
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollRegistration3step.frame.size.height = self.scrollViewHeight - self.keyboard.height
            self.scrollRegistration3step.setContentOffset(CGPoint(x:0, y:110), animated: true)
        }
    }
    
    
    // Method for set the scroll height on keyboard hide
    func setScrollHeightOnHide(notification :NSNotification){
        
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollRegistration3step.frame.size.height = self.view.frame.height
            self.scrollRegistration3step.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
        }
    }
    
    
    func scrollTap(recognizer: UITapGestureRecognizer){
        hideKeyboard()
    }
    
    
    // Method to end the editing and hide the Keyboard
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    
    // Method to hide the keyboard when the screen is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        hideKeyboard()
    }
    
    
        
    // -----------------------------------------------------------------------------------
    // ***************************** COLLECTION LANGUAGES ********************************
    
    
    
    // Cell delete methode
    func deleteCell(recognizer: UILongPressGestureRecognizer){
    
        let p = recognizer.locationInView(self.languagesCollection)
        let indexPath  = self.languagesCollection.indexPathForItemAtPoint(p)
        
        if let index = indexPath {
            
            self.userStep3.languages.removeAtIndex(index.row)
            self.languagesCollection.reloadData()
        }
    }
    
    
    // Method to change the input type of the date text field view
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! languageCellVC
            cell.langueLbl.text = self.userStep3.languages[indexPath.row].name
            cell.flag.image = self.userStep3.languages[indexPath.row].flag
        let longPressDelete = UILongPressGestureRecognizer(target: self, action: #selector(registration3stepVC.deleteCell(_:)))
            longPressDelete.minimumPressDuration = 0.5
            longPressDelete.delaysTouchesBegan = true
            longPressDelete.delegate = self
            cell.userInteractionEnabled = true
            cell.addGestureRecognizer(longPressDelete)
        
        return cell
    }
    
    
    // Defining the number of items in a section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.userStep3.languages.count > 0 {
            return self.userStep3.languages.count
        } else {
            return 0
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ***************************** PREPARE FOR SEGUE ***********************************
    
    
    
    // Passing data from current view controller to the languageTVC controller to complete the array
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "backToLanguageSelection" {
            
            let languageTable :languageTVC = segue.destinationViewController as! languageTVC
            languageTable.userStep3 = self.userStep3
            
        } else if segue.identifier == "backStep2" {
            
            let registration2step :registration2stepVC = segue.destinationViewController as! registration2stepVC
                registration2step.userStep2 = self.userStep3
        }
        
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ***************************** ABOUT ME TEXTVIEW ***********************************
    
    
    
    func setTextView(recognizer: UITapGestureRecognizer){
        self.aboutMeTxtV.becomeFirstResponder()
    }
}
