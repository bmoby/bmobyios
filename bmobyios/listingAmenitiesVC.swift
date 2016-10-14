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



//-------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ***********************************************
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    //---------------------------------------------------   amenities  ---------------------------------------------------------
    //
    @IBOutlet var breakfastImg: UIImageView!
    @IBOutlet weak var breakfastLbl: UILabel!
    
    //
    
    @IBOutlet var wifiInternetImg: UIImageView!
    @IBOutlet weak var wifiInternetLbl: UILabel!
    
    //
    
    @IBOutlet var wheelChairAccessibleImg: UIImageView!
    @IBOutlet weak var wheelchairLbl: UILabel!
    @IBOutlet var accessibleLbl: UILabel!
    
    
    //
    
    @IBOutlet var washerImg: UIImageView!
    @IBOutlet weak var washerLbl: UILabel!
    
    //
    
    @IBOutlet var dyerImg: UIImageView!
    @IBOutlet weak var dryerLbl: UILabel!
    
    //
    
    @IBOutlet var ironImg: UIImageView!
    @IBOutlet weak var ironLbl: UILabel!
    
    //
   
    @IBOutlet var tvlmg: UIImageView!
    @IBOutlet weak var tvLbl: UILabel!
    
    //
    
    @IBOutlet var lockForBedroomImg: UIImageView!
    @IBOutlet weak var lockForLbl: UILabel!
    @IBOutlet var bedroomLbl: UILabel!
    
    //
    
    @IBOutlet var elevatorImg: UIImageView!
    @IBOutlet weak var elevatorLbl: UILabel!
    
    //
    
    @IBOutlet var hairDryerImg: UIImageView!
    @IBOutlet weak var hairDryerLbl: UILabel!
    
    //
    
    @IBOutlet var smokingAllowed: UIImageView!
    @IBOutlet weak var smokingLbl: UILabel!
    @IBOutlet var allowedLbl: UILabel!
    
    
    //
    
    @IBOutlet var intercomImg: UIImageView!
    @IBOutlet weak var intercomLbl: UILabel!
    
    //
    
    @IBOutlet var airConditionerImg: UIImageView!
    @IBOutlet weak var airConditionerLbl: UILabel!
    
    //
    
    @IBOutlet var familyKidsImg: UIImageView!
    @IBOutlet weak var familyKidLbl: UILabel!
    
    //
    
    @IBOutlet var petsAllowedImg: UIImageView!
    @IBOutlet weak var petsAllowedLbl: UILabel!
    
    //
    @IBOutlet var parkingImg: UIImageView!
    @IBOutlet weak var parkingLbl: UILabel!
    
    //
    @IBOutlet var indoorFireplaceImg: UIImageView!
    @IBOutlet var idoorLbl: UILabel!
    @IBOutlet var fireplaceLbl: UILabel!
    
    //
    @IBOutlet var gymImg: UIImageView!
    @IBOutlet weak var gymLbl: UILabel!
    
    //
    @IBOutlet var poolImg: UIImageView!
    @IBOutlet weak var poolLbl: UILabel!
    
    //
    @IBOutlet var saunaImg: UIImageView!
    @IBOutlet weak var saunaLbl: UILabel!
    
    //
    
    @IBOutlet var hammamImg: UIImageView!
    @IBOutlet weak var hammamLbl: UILabel!
    
    //
    
    @IBOutlet var jacuzziImg: UIImageView!
    @IBOutlet weak var jacuzziLbl: UILabel!

    
    @IBOutlet var nextBtn: UIButton!
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    @IBAction func nextBtn_clicked(sender: AnyObject) {
    }
}
