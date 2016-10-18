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
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = self.view.frame.height
        let width = self.view.frame.size.width
        
        //scroll view content size: to scroll
        scrollView.contentSize = CGSize(width: width , height: height + 300)

        // completing image view array: chooseImg
        chooseImg = [breakfastImg, wifiInternetImg, wheelChairAccessibleImg, tvImg, lockForBedroomImg, elevatorImg, dryerImg, washerImg, ironImg, hairDryerImg, smokingAllowedImg, intercomImg, airConditionerImg, familyKidsImg, petsAllowedImg, parkingImg, indoorFireplaceImg, gymImg, poolImg, saunaImg, hammamImg, jacuzziImg]
        
        // chooseImg image view background color
        for object in chooseImg {
            object.backgroundColor = grayColor
        }
        
        // completing text array: chooseTxt
        let wheelchairAccessible = wheelchairLbl.text! + accessibleLbl.text!
        let lockForBedroom = lockForLbl.text! + " " + bedroomLbl.text!
        let smokingAllowed = smokingLbl.text! + " " + allowedLbl.text!
        let indoorFireplace = indoorLbl.text! + " " + fireplaceLbl.text!
        chooseTxt = [breakfastLbl.text!, wifiInternetLbl.text!, wheelchairAccessible, tvLbl.text!, lockForBedroom, elevatorLbl.text!, dryerLbl.text!, washerLbl.text!, ironLbl.text!, hairDryerLbl.text!, smokingAllowed, intercomLbl.text!, airConditionerLbl.text!, familyKidLbl.text!, petsAllowedLbl.text!, parkingLbl.text!, indoorFireplace, gymLbl.text!, poolLbl.text!, saunaLbl.text!, hammamLbl.text!, jacuzziLbl.text!]
        
        // Tap gesture recognizer: change the background color of chooseImg items background color
        for object in chooseImg {
            let tapImg =  UITapGestureRecognizer(target: self, action: #selector(listingAmenitiesVC.tapImg(_:)))
            tapImg.numberOfTapsRequired = 1
            object.userInteractionEnabled = true
            object.addGestureRecognizer(tapImg)
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
        listing.amenities.removeAll(keepCapacity: false)
        
        // picking up the string from chooseTxt that matchs with background color: append to amenities array
        for (txt, img) in zip(chooseTxt, chooseImg) {
            if img.backgroundColor == ownColor {
                listing.amenities.append(txt)
            }
        }
        
        // send data to database
        print("")
        print(listing.amenities)
        
        // going to next controller: listingPhotosVC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingPhotosVC") as! listingPhotosVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}
















