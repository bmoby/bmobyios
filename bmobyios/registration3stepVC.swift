//
//  registration3stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class registration3stepVC: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UITextViewDelegate {
    
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
        
        // Defining inter step user values to perform the prepareforsegues method with it
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
        self.userStep3.music = self.musicTxtF.text
        self.userStep3.aboutMe = self.aboutMeTxtV.text
        
        // Saving all in DB
        self.userStep3.save()
        
        // Run a spinner to show a task in progress
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        // Send a request to login
        PFUser.logInWithUsernameInBackground(userStep3.email!, password: userStep3.password!, block: { (user, error) -> Void in
            
            // Stop the spinner
            spinner.stopAnimating()
            if (user?.valueForKey("emailVerified")?.boolValue == true){
                if ((user) != nil) {
                    print("Logged in with success!")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                        let navigation = UINavigationController(rootViewController: viewController)
                        self.presentViewController(navigation, animated: true, completion: nil)
                    })
                } else {
                    print(error!.localizedDescription)
                }
                
            } else {
                // dispatch allows to do things in background much quicker and user dont feel anything its like a good practice
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewControllerWithIdentifier("NotVerified")
                    let navigation = UINavigationController(rootViewController: viewController)
                    self.presentViewController(navigation, animated: true, completion: nil)
                })
            }
        })
    }
    
    // Back btn outlet and action
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backClicked(sender: AnyObject) {
        // If we go back we need to save current page data to reset it when we come back
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
        self.userStep3.music = self.musicTxtF.text
        self.userStep3.aboutMe = self.aboutMeTxtV.text
        self.performSegueWithIdentifier("backStep2", sender: nil)
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
        self.navigationController?.navigationBar.hidden = true
        
        self.nationalityTxtF.delegate = self
        self.musicTxtF.delegate = self
        self.aboutMeTxtV.delegate = self
        self.professionTxtF.delegate = self
        
     }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.nationalityTxtF {
            self.professionTxtF.becomeFirstResponder()
            return true
        }else if(textField == professionTxtF){
            self.musicTxtF.nextResponder()
            return true
        } else if (textField == self.musicTxtF) {
            self.aboutMeTxtV.becomeFirstResponder()
            return true
        } else {
            self.aboutMeTxtV.becomeFirstResponder()
            self.submitClicked(self.submitBtn)
            return true
        }
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
    
    
    
    // Method that allows to set the scroll height on keyboard show
    func setScrollHeightOnShow(notification :NSNotification){

        keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]!.CGRectValue())!
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollRegistration3step.frame.size.height = self.scrollViewHeight - self.keyboard.height
            self.scrollRegistration3step.setContentOffset(CGPoint(x:0, y:110), animated: true)
        }
    }
    
    // Method that allows to set the scroll height on keyboard hide
    func setScrollHeightOnHide(notification :NSNotification){
        
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollRegistration3step.frame.size.height = self.view.frame.height
            self.scrollRegistration3step.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
        }
    }
    
    // Methid that hides the keyboard when the scrollview is tapped
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
    
    // Alert function this is a helper method that we can reuse for any alerts on this particular page
    func alerter(name: String, message: String){
        
        let alert = UIAlertController(title: name, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        presentViewController(alert, animated: true, completion: nil)
        
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
    
    
    // Method that allow to tap one time on the TextView to edit it instead double click on it
    func setTextView(recognizer: UITapGestureRecognizer){
        self.aboutMeTxtV.becomeFirstResponder()
    }
}
