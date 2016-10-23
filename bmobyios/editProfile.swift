//
//  editProfile.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 20/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class editProfile: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentuser = user()
    var languageArray = [language]()
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

    
    
    // -----------------------------------------------------------------------------------
    //********************************* DEFAULT METHODS **********************************
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.collectionLanguages.backgroundColor = UIColor.whiteColor()
        
        // Set the scroll content size
        self.profileScroll.contentSize = self.scrollContentView.frame.size
        self.avatarImgV.layer.cornerRadius = self.avatarImgV.frame.size.width / 2
        self.avatarImgV.layer.masksToBounds = true
        self.collectionLanguages.delegate = self
        self.collectionLanguages.dataSource = self

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.setValues()
        self.collectionLanguages.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** OUTLETS AND ACTIONS **********************************
    
    

    @IBOutlet weak var profileScroll: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    
    // Personal information outlaets
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var avatarImgV: UIImageView!
    @IBOutlet weak var birthDateLbl: UILabel!
    @IBAction func editPersonalInfoBtnClicked(sender: AnyObject) {
        //Action to edit personal info
        let story = UIStoryboard(name: "SignIn", bundle: nil)
        let personalInfoEdit = story.instantiateViewControllerWithIdentifier("step2") as! registration2stepVC
        
        self.presentViewController(personalInfoEdit, animated: true, completion: nil)
        
        
        
    }
    
    // Accaunt informations
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBAction func editAccauntInfoBtnClicked(sender: AnyObject) {
        //Action to edit accaunt info
        let story = UIStoryboard(name: "SignIn", bundle: nil)
        let profileInfoEdit = story.instantiateViewControllerWithIdentifier("step1") as! registrationVC
        
        
        self.presentViewController(profileInfoEdit, animated: true, completion: nil)
    }
    
    // Other informations
    @IBOutlet weak var nationalityLbl: UILabel!
    @IBOutlet weak var professionLbl: UILabel!
    @IBOutlet weak var aboutMeTxtV: UITextView!
    @IBOutlet weak var collectionLanguages: UICollectionView!
    @IBAction func editOtherInfoBtnClicked(sender: AnyObject) {
        let story = UIStoryboard(name: "SignIn", bundle: nil)
        let personalInfoEdit = story.instantiateViewControllerWithIdentifier("step3") as! registration3stepVC
        
        self.presentViewController(personalInfoEdit, animated: true, completion: nil)
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** SET THE VALUES ACTION ********************************
    
    
    
    func setValues() {
        
        let ava = PFUser.currentUser()!.objectForKey("avatar") as! PFFile
        ava.getDataInBackgroundWithBlock { (data:NSData?, error:NSError?) in
            if error == nil {
                self.currentuser.avatar.image = UIImage(data: data!)
                self.avatarImgV.image = self.currentuser.avatar.image
            } else {
                print(error!.localizedDescription)
            }
        }
        
        self.currentuser.firstName = PFUser.currentUser()?.valueForKey("firstName") as? String
        self.currentuser.lastName = PFUser.currentUser()?.valueForKey("lastName") as? String
        self.currentuser.birthDate = PFUser.currentUser()?.valueForKey("birthDate") as? String
        self.currentuser.profession = PFUser.currentUser()?.valueForKey("profession") as? String
        self.currentuser.phone = PFUser.currentUser()?.valueForKey("phone") as? String
        self.currentuser.email = PFUser.currentUser()?.valueForKey("email") as? String
        self.currentuser.aboutMe = PFUser.currentUser()?.valueForKey("aboutMe") as? String
        self.currentuser.nationality = PFUser.currentUser()?.valueForKey("nationality") as? String
        
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
            
            self.langue1.name = "\(langu!)"
            self.langue1.flag = UIImage(named: "\(langu!)")!
            self.languageArray.append(langue1)
        }
        if langu2 != nil {
            
            self.langue2.name = "\(langu2!)"
            self.langue2.flag = UIImage(named: "\(langu2!)")!
            self.languageArray.append(langue2)
        }
        if langu3 != nil {
            
            self.langue3.name = "\(langu3!)"
            self.langue3.flag = UIImage(named: "\(langu3!)")!
            self.languageArray.append(langue3)
        }
        if langu4 != nil {
            
            self.langue4.name = "\(langu4!)"
            self.langue4.flag = UIImage(named: "\(langu4!)")!
            self.languageArray.append(langue4)
        }
        if langu5 != nil {
            
            self.langue5.name = "\(langu5!)"
            self.langue5.flag = UIImage(named: "\(langu5!)")!
            self.languageArray.append(langue5)
        }
        if langu6 != nil {
            
            self.langue6.name = "\(langu6!)"
            self.langue6.flag = UIImage(named: "\(langu6!)")!
            self.languageArray.append(langue6)
        }
        if langu7 != nil {
            
            self.langue7.name = "\(langu7!)"
            self.langue7.flag = UIImage(named: "\(langu7!)")!
            self.languageArray.append(langue7)
        }
        if langu8 != nil {
            
            self.langue8.name = "\(langu8!)"
            self.langue8.flag = UIImage(named: "\(langu8!)")!
            self.languageArray.append(langue8)
        }
        if langu9 != nil {
            
            self.langue9.name = "\(langu9!)"
            self.langue9.flag = UIImage(named: "\(langu9!)")!
            self.languageArray.append(langue9)
        }
        if langu10 != nil {
            
            self.langue10.name = "\(langu10!)"
            self.langue10.flag = UIImage(named: "\(langu10!)")!
            self.languageArray.append(langue10)
        }
        
        self.firstNameLbl.text = self.currentuser.firstName
        self.lastNameLbl.text = self.currentuser.lastName
        self.birthDateLbl.text = self.currentuser.birthDate
        self.emailLbl.text = self.currentuser.email
        if self.currentuser.phone != "" {
            self.phoneLbl.text = self.currentuser.phone
        } else {
            self.phoneLbl.text = "Add a phone number (+99...)"
        }
        
        self.aboutMeTxtV.text = self.currentuser.aboutMe
        if self.currentuser.profession != "" {
           self.professionLbl.text = self.currentuser.profession
        } else {
            self.professionLbl.text = "Add a profession!"
        }
        
        if self.currentuser.nationality != "" {
            self.nationalityLbl.text = self.currentuser.nationality
        } else {
            self.nationalityLbl.text = "Add your nationality!"
        }
        
        self.currentuser.languages = self.languageArray
    }


    
    // -----------------------------------------------------------------------------------
    //***************************** LANGUAGE COLLECTION V ********************************
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.currentuser.languages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("langCell", forIndexPath: indexPath) as! languageCell
        if self.currentuser.languages.count != 0 {
            cell.flagImg.image = self.languageArray[indexPath.row].flag
            cell.name.text = self.languageArray[indexPath.row].name
        } else {
            cell.name.text = "Empty"
        }
        
        return cell
    }
}
