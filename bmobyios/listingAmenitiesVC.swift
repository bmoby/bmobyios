//
//  listingAmenities.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/14/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class listingAmenitiesVC: UIViewController {

//--------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    
    var createListingAmenities = listingClass()
    
    // listing id to update the photos and controller to show the update buttons
    var id = String()
    var controller = String()
    
    // to change background color of image views
    var chooseImg = [UIImageView]()
    
    // to choose the label text if imgae view background color is own color
    var chooseTxt = [String]()
    
    // array containing data to send to the database
    //var amenities = [String]()
    
    // colors
    var grayColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)
    var ownColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 92.0/255.0, alpha: 1)

//-------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ***********************************************
    
    // scroll view
    @IBOutlet var scrollView: UIScrollView!
    
    //----------------------------------------------   amenities  --------------------------------
    // breakfast
    @IBOutlet var breakfastImg: UIImageView!
    @IBOutlet weak var breakfastLbl: UILabel!
    
    // wifi/internet
    @IBOutlet var wifiInternetImg: UIImageView!
    @IBOutlet weak var wifiInternetLbl: UILabel!
    
    // wheelchair accessible
    @IBOutlet var wheelChairAccessibleImg: UIImageView!
    @IBOutlet weak var wheelchairLbl: UILabel!
    @IBOutlet var accessibleLbl: UILabel!
    
    
    // washer
    @IBOutlet var washerImg: UIImageView!
    @IBOutlet weak var washerLbl: UILabel!
    
    // dryer
    @IBOutlet var dryerImg: UIImageView!
    @IBOutlet weak var dryerLbl: UILabel!
    
    // iron
    @IBOutlet var ironImg: UIImageView!
    @IBOutlet weak var ironLbl: UILabel!
    
    // tv
    @IBOutlet var tvImg: UIImageView!
    @IBOutlet weak var tvLbl: UILabel!
    
    // lock for bedroom
    @IBOutlet var lockForBedroomImg: UIImageView!
    @IBOutlet weak var lockForLbl: UILabel!
    @IBOutlet var bedroomLbl: UILabel!
    
    // elevator
    @IBOutlet var elevatorImg: UIImageView!
    @IBOutlet weak var elevatorLbl: UILabel!
    
    // hair dryer
    @IBOutlet var hairDryerImg: UIImageView!
    @IBOutlet weak var hairDryerLbl: UILabel!
    
    // smoking allowed
    @IBOutlet var smokingAllowedImg: UIImageView!
    @IBOutlet weak var smokingLbl: UILabel!
    @IBOutlet var allowedLbl: UILabel!
    
    
    // intercom
    @IBOutlet var intercomImg: UIImageView!
    @IBOutlet weak var intercomLbl: UILabel!
    
    // air conditioner
    @IBOutlet var airConditionerImg: UIImageView!
    @IBOutlet weak var airConditionerLbl: UILabel!
    
    // family/kids
    @IBOutlet var familyKidsImg: UIImageView!
    @IBOutlet weak var familyKidLbl: UILabel!
    
    // pets allowed
    @IBOutlet var petsAllowedImg: UIImageView!
    @IBOutlet weak var petsAllowedLbl: UILabel!
    
    // parking
    @IBOutlet var parkingImg: UIImageView!
    @IBOutlet weak var parkingLbl: UILabel!
    
    //indoor fireplace
    @IBOutlet var indoorFireplaceImg: UIImageView!
    @IBOutlet var indoorLbl: UILabel!
    @IBOutlet var fireplaceLbl: UILabel!
    
    // gym
    @IBOutlet var gymImg: UIImageView!
    @IBOutlet weak var gymLbl: UILabel!
    
    // pool
    @IBOutlet var poolImg: UIImageView!
    @IBOutlet weak var poolLbl: UILabel!
    
    // sauna
    @IBOutlet var saunaImg: UIImageView!
    @IBOutlet weak var saunaLbl: UILabel!
    
    // hammam
    @IBOutlet var hammamImg: UIImageView!
    @IBOutlet weak var hammamLbl: UILabel!
    
    // jacuzzi
    @IBOutlet var jacuzziImg: UIImageView!
    @IBOutlet weak var jacuzziLbl: UILabel!

    // next button
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    
    // update and do not update buttons
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var doNotUpdateBtn: UIButton!
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        
        let height = self.view.frame.height
        let width = self.view.frame.size.width
        
        //scroll view content size: to scroll
        scrollView.contentSize = CGSize(width: width , height: height + 300)

        // completing image view array: chooseImg
        chooseImg = [breakfastImg, wifiInternetImg, wheelChairAccessibleImg, tvImg, lockForBedroomImg, elevatorImg, dryerImg, washerImg, ironImg, hairDryerImg, smokingAllowedImg, intercomImg, airConditionerImg, familyKidsImg, petsAllowedImg, parkingImg, indoorFireplaceImg, gymImg, poolImg, saunaImg, hammamImg, jacuzziImg]
        
        // completing text array: chooseTxt
        let wheelchairAccessible = wheelchairLbl.text! + accessibleLbl.text!
        let lockForBedroom = lockForLbl.text! + " " + bedroomLbl.text!
        let smokingAllowed = smokingLbl.text! + " " + allowedLbl.text!
        let indoorFireplace = indoorLbl.text! + " " + fireplaceLbl.text!
        chooseTxt = [breakfastLbl.text!, wifiInternetLbl.text!, wheelchairAccessible, tvLbl.text!, lockForBedroom, elevatorLbl.text!, dryerLbl.text!, washerLbl.text!, ironLbl.text!, hairDryerLbl.text!, smokingAllowed, intercomLbl.text!, airConditionerLbl.text!, familyKidLbl.text!, petsAllowedLbl.text!, parkingLbl.text!, indoorFireplace, gymLbl.text!, poolLbl.text!, saunaLbl.text!, hammamLbl.text!, jacuzziLbl.text!]
        
        
        for object in chooseImg {

            // imageview background color
            object.backgroundColor = grayColor
            
            // Tap gesture recognizer: change the background color of chooseImg items background color
            let tapImg =  UITapGestureRecognizer(target: self, action: #selector(listingAmenitiesVC.tapImg(_:)))
            tapImg.numberOfTapsRequired = 1
            object.userInteractionEnabled = true
            object.addGestureRecognizer(tapImg)
        }
        
        // displaying choosen amenities by host once if went back to previous controller and came back to this one
        if createListingAmenities.amenities.isEmpty == false {
            for object in createListingAmenities.amenities {
                for (img, txt) in zip(chooseImg, chooseTxt) {
                    if object == txt {
                        img.backgroundColor = ownColor
                    }
                }
            }
        }
        
        // hide and show buttons dependng on previous controller
        if controller == "myListngVC" {
            nextBtn.hidden = true
            backBtn.hidden = true
            
            updateBtn.hidden = false
            doNotUpdateBtn.hidden = false
        }
        else {
            nextBtn.hidden = false
            backBtn.hidden = false
            
            updateBtn.hidden = true
            doNotUpdateBtn.hidden = true
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** TAP GESTURE *******************************************
    func tapImg(sender: UITapGestureRecognizer) {
        let lblChoose = sender
        if lblChoose.view?.backgroundColor == grayColor {
            lblChoose.view!.backgroundColor
                = ownColor
        }
        else {
            lblChoose.view!.backgroundColor = grayColor
        }
    }


    
//-------------------------------------------------------------------------------------------------
//*********************************** GOING TO THE NEXT CONTROLLER ********************************
    @IBAction func nextBtn_clicked(sender: AnyObject) {
        
        //cleaning the amenities array
        createListingAmenities.amenities.removeAll(keepCapacity: false)
        
        // picking up the string from chooseTxt that matchs with background color: append to amenities array
        for (txt, img) in zip(chooseTxt, chooseImg) {
            if img.backgroundColor == ownColor {
                createListingAmenities.amenities.append(txt)
            }
        }
        
        
        // going to next controller: listingPhotosVC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingPhotosVC") as! listingPhotosVC
        self.navigationController?.pushViewController(next, animated: true)
        next.createListingPhotos = createListingAmenities
        print(createListingAmenities.amenities)
        
    }
    
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        
        //cleaning the amenities array
        createListingAmenities.amenities.removeAll(keepCapacity: false)
        
        // picking up the string from chooseTxt that matchs with background color: append to amenities array
        for (txt, img) in zip(chooseTxt, chooseImg) {
            if img.backgroundColor == ownColor {
                createListingAmenities.amenities.append(txt)
            }
        }
        
        // going back: listingInfo2VC
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo2VC") as! listingInfo2VC
        self.navigationController?.pushViewController(back, animated: true)
        back.createListingInfo2 = createListingAmenities
    }
    


    //-------------------------------------------------------------------------------------------------
    //*********************************** UPDATING listingInfo2VC TYPES *******************************
    @IBAction func updateBtn_clicked(sender: AnyObject) {
        
        removeAmenities()
        
        //cleaning the amenities array
        createListingAmenities.amenities.removeAll(keepCapacity: false)
        
        // picking up the string from chooseTxt that matchs with background color: append to amenities array
        for (txt, img) in zip(chooseTxt, chooseImg) {
            if img.backgroundColor == ownColor {
                createListingAmenities.amenities.append(txt)
            }
        }

        
        //the dafault value to send in database
        let query = PFQuery(className: "listing")
        query.getObjectInBackgroundWithId(self.id) {(object: PFObject?, error: NSError?) in
            
            if error == nil {
                
                //amenities
                if self.createListingAmenities.amenities.count > 0 {
                    object!["amenity0"] = self.createListingAmenities.amenities[0]
                }
                if self.createListingAmenities.amenities.count > 1 {
                    object!["amenity1"] = self.createListingAmenities.amenities[1]
                }
                if self.createListingAmenities.amenities.count > 2 {
                    object!["amenity2"] = self.createListingAmenities.amenities[2]
                }
                if self.createListingAmenities.amenities.count > 3 {
                    object!["amenity3"] = self.createListingAmenities.amenities[3]
                }
                if self.createListingAmenities.amenities.count > 4 {
                    object!["amenity4"] = self.createListingAmenities.amenities[4]
                }
                if self.createListingAmenities.amenities.count > 5 {
                    object!["amenity5"] = self.createListingAmenities.amenities[5]
                }
                if self.createListingAmenities.amenities.count > 6 {
                    object!["amenity6"] = self.createListingAmenities.amenities[6]
                }
                if self.createListingAmenities.amenities.count > 7 {
                    object!["amenity7"] = self.createListingAmenities.amenities[7]
                }
                if self.createListingAmenities.amenities.count > 8 {
                    object!["amenity8"] = self.createListingAmenities.amenities[8]
                }
                if self.createListingAmenities.amenities.count > 9 {
                    object!["amenity9"] = self.createListingAmenities.amenities[9]
                }
                if self.createListingAmenities.amenities.count > 10 {
                    object!["amenity10"] = self.createListingAmenities.amenities[10]
                }
                if self.createListingAmenities.amenities.count > 11 {
                    object!["amenity11"] = self.createListingAmenities.amenities[11]
                }
                if self.createListingAmenities.amenities.count > 12 {
                    object!["amenity12"] = self.createListingAmenities.amenities[12]
                }
                if self.createListingAmenities.amenities.count > 13 {
                    object!["amenity13"] = self.createListingAmenities.amenities[13]
                }
                if self.createListingAmenities.amenities.count > 14 {
                    object!["amenity14"] = self.createListingAmenities.amenities[14]
                }
                if self.createListingAmenities.amenities.count > 15 {
                    object!["amenity15"] = self.createListingAmenities.amenities[15]
                }
                if self.createListingAmenities.amenities.count > 16 {
                    object!["amenity16"] = self.createListingAmenities.amenities[16]
                }
                if self.createListingAmenities.amenities.count > 17 {
                    object!["amenity17"] = self.createListingAmenities.amenities[17]
                }
                if self.createListingAmenities.amenities.count > 18 {
                    object!["amenity18"] = self.createListingAmenities.amenities[18]
                }
                if self.createListingAmenities.amenities.count > 19 {
                    object!["amenity19"] = self.createListingAmenities.amenities[19]
                }
                if self.createListingAmenities.amenities.count > 20 {
                    object!["amenity20"] = self.createListingAmenities.amenities[20]
                }
                if self.createListingAmenities.amenities.count > 21 {
                    object!["amenity21"] = self.createListingAmenities.amenities[21]
                }

                
                object?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                    if error == nil {
                        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
                        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
                        back.id = self.id
                        self.navigationController?.pushViewController(back, animated: true)
                        
                        print("adress has been successfully updated")
                        
                    }
                    else {
                        print(error?.localizedDescription)
                    }
                })
                
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    // removing all photos before update
    func removeAmenities() {
        let query = PFQuery(className: "listing")
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) in
            
            if error == nil {
                if object?.objectId == self.id {
                    
                    object?.removeObjectForKey("amenity0")
                    object?.removeObjectForKey("amenity1")
                    object?.removeObjectForKey("amenity2")
                    object?.removeObjectForKey("amenity3")
                    object?.removeObjectForKey("amenity4")
                    object?.removeObjectForKey("amenity5")
                    object?.removeObjectForKey("amenity6")
                    object?.removeObjectForKey("amenity7")
                    object?.removeObjectForKey("amenity8")
                    object?.removeObjectForKey("amenity9")
                    object?.removeObjectForKey("amenity10")
                    object?.removeObjectForKey("amenity11")
                    object?.removeObjectForKey("amenity12")
                    object?.removeObjectForKey("amenity13")
                    object?.removeObjectForKey("amenity14")
                    object?.removeObjectForKey("amenity15")
                    object?.removeObjectForKey("amenity16")
                    object?.removeObjectForKey("amenity17")
                    object?.removeObjectForKey("amenity18")
                    object?.removeObjectForKey("amenity19")
                    object?.removeObjectForKey("amenity20")
                    object?.removeObjectForKey("amenity21")
                }
                
                object?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                    if error == nil {
                        print("amenities have been deleted")
                    }
                    else {
                        print(error?.localizedDescription)
                    }
                })
            }
            else {
                print(error?.localizedDescription)
            }
            
        }
        
    }

    
    
    
    //-------------------------------------------------------------------------------------------------
    //*********************** GOING BACK TO THE myListingVC: no update ********************************
    @IBAction func doNotUpdateBtn_clicked(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
        back.id = self.id
        self.navigationController?.pushViewController(back, animated: true)
    }
    
}


















