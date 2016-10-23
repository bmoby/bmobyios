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
    
    
    // Nationality & profession & text fields -----------------
    @IBOutlet weak var nationalityTxtF: UITextField!
    @IBOutlet weak var professionTxtF: UITextField!
    
    
    // AboutMe text view --------------------------------------
    @IBOutlet weak var aboutMeTxtV: UITextView!
    
    
    // Submit & back  button ----------------------------------
    @IBOutlet weak var submitBtn: UIButton!
    @IBAction func submitClicked(sender: AnyObject) {
        
        // Defining inter step user values to perform the prepareforsegues method with it
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
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
        self.userStep3.aboutMe = self.aboutMeTxtV.text
        self.performSegueWithIdentifier("backStep2", sender: nil)
    }
    
    // Scroll view
    @IBOutlet weak var scrollRegistration3step: UIScrollView!
    
    // Add a language btn
    
    @IBOutlet weak var addLanguageBtn: UIButton!
    @IBAction func addLanguageClicked(sender: AnyObject) {
        
        self.userStep3.nationality = self.nationalityTxtF.text
        self.userStep3.profession = self.professionTxtF.text
        self.userStep3.aboutMe = self.aboutMeTxtV.text
    }
    
    
    @IBOutlet weak var addLanguage2Btn: UIButton!
    @IBAction func addLanguage2BtnClciked(sender: AnyObject) {
        performSegueWithIdentifier("modalToLanguageTable", sender: nil)
    }
    
    
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func saveBtnClicked(sender: AnyObject) {
        PFUser.currentUser()?.setValue(self.professionTxtF.text, forKey: "profession")
        PFUser.currentUser()?.setValue(self.nationalityTxtF.text, forKey: "nationality")
        PFUser.currentUser()?.setValue(self.aboutMeTxtV.text, forKey: "aboutMe")
        removeAllLanguagesFromDB()
        if self.userStep3.languages.count > 0{
            PFUser.currentUser()?.setValue(self.userStep3.languages[0].name, forKey: "language01")
        }
        if self.userStep3.languages.count > 1{
            PFUser.currentUser()?.setValue(self.userStep3.languages[1].name, forKey: "language02")
        }
        if self.userStep3.languages.count > 2{
            PFUser.currentUser()?.setValue(self.userStep3.languages[2].name, forKey: "language03")
        }
        if self.userStep3.languages.count > 3{
            PFUser.currentUser()?.setValue(self.userStep3.languages[3].name, forKey: "language04")
        }
        if self.userStep3.languages.count > 4{
            PFUser.currentUser()?.setValue(self.userStep3.languages[4].name, forKey: "language05")
        }
        if self.userStep3.languages.count > 5{
            PFUser.currentUser()?.setValue(self.userStep3.languages[5].name, forKey: "language06")
        }
        if self.userStep3.languages.count > 6{
            PFUser.currentUser()?.setValue(self.userStep3.languages[6].name, forKey: "language07")
        }
        if self.userStep3.languages.count > 7{
            PFUser.currentUser()?.setValue(self.userStep3.languages[7].name, forKey: "language08")
        }
        if self.userStep3.languages.count > 8{
            PFUser.currentUser()?.setValue(self.userStep3.languages[8].name, forKey: "language09")
        }
        if self.userStep3.languages.count > 9{
            PFUser.currentUser()?.setValue(self.userStep3.languages[9].name, forKey: "language10")
        }
        
        PFUser.currentUser()?.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) in
            if error == nil {
                print("User saved with success")
            }
        })
        
        let story = UIStoryboard(name: "profileSB", bundle: nil)
        let profileInfoEdit = story.instantiateViewControllerWithIdentifier("editProf") as! editProfile
        self.presentViewController(profileInfoEdit, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnClicked(sender: AnyObject) {
        let story = UIStoryboard(name: "profileSB", bundle: nil)
        let profileInfoEdit = story.instantiateViewControllerWithIdentifier("editProf") as! editProfile
        self.presentViewController(profileInfoEdit, animated: true, completion: nil)
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
        
        self.navigationController?.navigationBar.hidden = true
        
        self.nationalityTxtF.delegate = self
        self.aboutMeTxtV.delegate = self
        self.professionTxtF.delegate = self
        
        // This conditional is set to find the case of editing and creating (which one is actual case?)
        if PFUser.currentUser() == nil {
            setValuesIfExist()
            self.cancelBtn.hidden = true
            self.saveBtn.hidden = true
            self.addLanguage2Btn.hidden = true
            
        } else {
            setCurrentUserValues()
            self.backBtn.hidden = true
            self.submitBtn.hidden = true
            self.addLanguageBtn.hidden = true
        }
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
        
        if self.userStep3.nationality != nil {
            self.nationalityTxtF.text = self.userStep3.nationality
        }
        if self.userStep3.profession != nil {
            self.professionTxtF.text = self.userStep3.profession
        }
        if self.userStep3.aboutMe != nil {
            self.aboutMeTxtV.text = self.userStep3.aboutMe
        }
        if self.userStep3.languages.count > 0 {
            languagesCollection.reloadData()
        }
    }
    
    // If the user commes to edit his/her info
    func setCurrentUserValues() {
        
        self.nationalityTxtF.text = PFUser.currentUser()?.valueForKey("nationality") as? String
        self.professionTxtF.text = PFUser.currentUser()?.valueForKey("profession") as? String
        self.aboutMeTxtV.text = PFUser.currentUser()?.valueForKey("aboutMe") as? String
        if self.userStep3.languages.count == 0 {
        
        let langue1 = language()
        let langue2 = language()
        let langue3 = language()
        let langue4 = language()
        let langue5 = language()
        let langue6 = language()
        let langue7 = language()
        let langue8 = language()
        let langue9 = language()
        let langue10 = language()
        
        let langu = PFUser.currentUser()?.valueForKey("language01") as? String
        let langu2 = PFUser.currentUser()?.valueForKey("language02") as? String
        let langu3 = PFUser.currentUser()?.valueForKey("language03") as? String
        let langu4 = PFUser.currentUser()?.valueForKey("language04") as? String
        let langu5 = PFUser.currentUser()?.valueForKey("language05") as? String
        let langu6 = PFUser.currentUser()?.valueForKey("language06") as? String
        let langu7 = PFUser.currentUser()?.valueForKey("language07") as? String
        let langu8 = PFUser.currentUser()?.valueForKey("language08") as? String
        let langu9 = PFUser.currentUser()?.valueForKey("language09") as? String
        let langu10 = PFUser.currentUser()?.valueForKey("language10") as? String
        
        if langu != nil {
            
            langue1.name = "\(langu!)"
            langue1.flag = UIImage(named: "\(langu!)")!
            self.userStep3.languages.append(langue1)
        }
        if langu2 != nil {
            
            langue2.name = "\(langu2!)"
            langue2.flag = UIImage(named: "\(langu2!)")!
            self.userStep3.languages.append(langue2)
        }
        if langu3 != nil {
            
            langue3.name = "\(langu3!)"
            langue3.flag = UIImage(named: "\(langu3!)")!
            self.userStep3.languages.append(langue3)
        }
        if langu4 != nil {
            
            langue4.name = "\(langu4!)"
            langue4.flag = UIImage(named: "\(langu4!)")!
            self.userStep3.languages.append(langue4)
        }
        if langu5 != nil {
            
            langue5.name = "\(langu5!)"
            langue5.flag = UIImage(named: "\(langu5!)")!
            self.userStep3.languages.append(langue5)
        }
        if langu6 != nil {
            
            langue6.name = "\(langu6!)"
            langue6.flag = UIImage(named: "\(langu6!)")!
            self.userStep3.languages.append(langue6)
        }
        if langu7 != nil {
            
            langue7.name = "\(langu7!)"
            langue7.flag = UIImage(named: "\(langu7!)")!
            self.userStep3.languages.append(langue7)
        }
        if langu8 != nil {
            
            langue8.name = "\(langu8!)"
            langue8.flag = UIImage(named: "\(langu8!)")!
            self.userStep3.languages.append(langue8)
        }
        if langu9 != nil {
            
            langue9.name = "\(langu9!)"
            langue9.flag = UIImage(named: "\(langu9!)")!
            self.userStep3.languages.append(langue9)
        }
        if langu10 != nil {
            
            langue10.name = "\(langu10!)"
            langue10.flag = UIImage(named: "\(langu10!)")!
            self.userStep3.languages.append(langue10)
        }
        
        self.languagesCollection.reloadData()
        }
    }
    
    // Clean up languages in the DB befor edit languages
    func removeAllLanguagesFromDB() {
        PFUser.currentUser()?.removeObjectForKey("language01")
        PFUser.currentUser()?.removeObjectForKey("language02")
        PFUser.currentUser()?.removeObjectForKey("language03")
        PFUser.currentUser()?.removeObjectForKey("language04")
        PFUser.currentUser()?.removeObjectForKey("language05")
        PFUser.currentUser()?.removeObjectForKey("language06")
        PFUser.currentUser()?.removeObjectForKey("language07")
        PFUser.currentUser()?.removeObjectForKey("language08")
        PFUser.currentUser()?.removeObjectForKey("language09")
        PFUser.currentUser()?.removeObjectForKey("language10")
        PFUser.currentUser()?.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) in
            if success {
                print("Languages are empty in DB")
            }
        })
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
        if PFUser.currentUser() == nil {
            let p = recognizer.locationInView(self.languagesCollection)
            let indexPath  = self.languagesCollection.indexPathForItemAtPoint(p)
            if let index = indexPath {
                self.userStep3.languages.removeAtIndex(index.row)
                self.languagesCollection.reloadData()
            }
        } else {
            let p = recognizer.locationInView(self.languagesCollection)
            let indexPath  = self.languagesCollection.indexPathForItemAtPoint(p)
            if let index = indexPath {
                self.userStep3.languages.removeAtIndex(index.row)
                self.languagesCollection.reloadData()
            }
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
        } else if segue.identifier == "modalToLanguageTable" {
            let languageTable :languageTVC = segue.destinationViewController as! languageTVC
            languageTable.userStep3.languages = self.userStep3.languages
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ***************************** ABOUT ME TEXTVIEW ***********************************
    
    
    
    // Method that allow to tap one time on the TextView to edit it instead double click on it
    func setTextView(recognizer: UITapGestureRecognizer){
        self.aboutMeTxtV.becomeFirstResponder()
    }
}
