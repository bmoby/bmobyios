//
//  listingInfoVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/11/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class listingInfo3VC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
//-------------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES *********************************************
    
    //data to send to database
    var price = String()
    var checkin = String()
    var daysORmontths = String()
    var hostingPeriod = String()
    
    //Reset default size
    var scrollViewHeight: CGFloat = 0
    
    // keyboard frame size
    var keyboard = CGRect()
    
    //Colors
    var ownColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 92.0/255.0, alpha: 1)
    var grayColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)

    //choose days or months
    var daysORmonths = String()
    
    // range slider
    var rangeSlider: RangeSlider = RangeSlider()
    
    //checkin pickerview and picker data
    var hour:String = ""
    var minute:String = ""
    var checkinPicker: UIPickerView!
    var checkinData = [["any hour","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"], ["any minute","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"] ]
    var hourRestriction = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    var minRestriction = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
    var checkinRestriction = [String]()
    
    
//-------------------------------------------------------------------------------------------------------
//***************************************** OUTLETS *****************************************************
    
    // header
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    
    //price
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceHeaderLbl: UILabel!
    @IBOutlet weak var priceImg: UIImageView!
    @IBOutlet weak var priceTxt: UITextField!
    
    //number of nights
    @IBOutlet weak var nightsHeaderLbl: UILabel!
    @IBOutlet weak var daysBtn: UIButton!
    @IBOutlet weak var monthsBtn: UIButton!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var minValueLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var maxValueLbl: UILabel!
    
    //checkin time
    @IBOutlet weak var checkinHeaderLbl: UILabel!
    @IBOutlet weak var checkinTxt: UITextField!
        
    // list button
    @IBOutlet weak var listBtn: UIButton!
    
    
//------------------------------------------------------------------------------------------------------
//***************************************** DEFAULT *****************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tap to hide the keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(listingInfo3VC.hideKeyboard))
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        
        //numeric keyboard for price text field
        priceTxt.delegate = self
        priceTxt.keyboardType = UIKeyboardType.NumberPad
        
        
        //range slider
        rangeSlider.frame = CGRectMake(22, 440, self.view.frame.width - 44, 40)
        rangeSlider.minimumValue = 0
        rangeSlider.maximumValue = 100
        rangeSlider.lowerValue = 0
        rangeSlider.upperValue = 100
        rangeSlider.trackHighlightTintColor = ownColor
        rangeSlider.thumbTintColor = UIColor.whiteColor()
        //rangeSlider.thumbBorderWidth = 5
        rangeSlider.curvaceousness = 1.0
        self.view.addSubview(rangeSlider)
        rangeSlider.addTarget(self, action: #selector(listingInfo3VC.rangeSliderValueChanged(_:)),forControlEvents: .ValueChanged)
        
        //checkin picker
        checkinPicker = UIPickerView()
        checkinPicker.dataSource = self
        checkinPicker.delegate = self
        checkinPicker.backgroundColor = UIColor.groupTableViewBackgroundColor()
        checkinPicker.showsSelectionIndicator = true
        checkinTxt.inputView = checkinPicker
        
        
        // checkin restriction array
        checkinRestriction.append("any time")
        for h in hourRestriction {
            for min in minRestriction {
                checkinRestriction.append(h + ":" + min)
            }
        }
        
        /*
        for object in checkinRestriction {
            print(object)
        }
        print(checkinRestriction)
        */
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
//------------------------------------------------------------------------------------------------------
//***************************************** OTHERS *****************************************************
    
    // hide the keyboard
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
//------------------------------------------------------------------------------------------------------
//***************************************** DYAS/MONTHS ************************************************
    
    // user chooses to host for some days
    @IBAction func daysBtn_clicked(sender: AnyObject) {
        daysBtn.backgroundColor = ownColor
        monthsBtn.backgroundColor = grayColor
        daysORmonths = "days"
        print(daysORmonths)
    }
    
    // user chooses to host for some months
    @IBAction func monthsBtn_clicked(sender: AnyObject) {
        daysBtn.backgroundColor = grayColor
        monthsBtn.backgroundColor = ownColor
        daysORmonths = "months"
        print(daysORmonths)
    }
    
    // range slider min and max values displaying
    func rangeSliderValueChanged(sender: RangeSlider) {
        minValueLbl.text = "\(Int(rangeSlider.lowerValue))"
        maxValueLbl.text = "\(Int(rangeSlider.upperValue))"
        
        //setting the min value to 1 when lowerValue = 0
        if minValueLbl.text == "0" {
            minValueLbl.text = "1"
        }
        
        //setting the max value to 100+ when upperValue = 100
        if maxValueLbl.text == "100" {
            maxValueLbl.text = "100+"
        }
    }
    
    //--------------------------------------------PICKER VIEW METHODS----------------------------------
    
    // number of components: one component the string array of hour
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return checkinData.count
    }
    
    //number of items to be selected
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return checkinData[component].count
    }
    
    //the title of items to be selected
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return checkinData[component][row]
    }
    
    //picker text config
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hour = checkinData[0][pickerView.selectedRowInComponent(0)]
        minute = checkinData[1][pickerView.selectedRowInComponent(1)]
        checkinTxt.text = hour + ":" + minute
        if checkinTxt.text == "any hour:any minute" || checkinTxt.text == nil {
            checkinTxt.text = "any time"
        }
    }
    

    
//-----------------------------------------------------------------------------------------------------
//**************************************** GOING TO THE NEXT CONTROLLER *******************************
    
    // alert function
    func alert(error: String, message: String) {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // list the place
    @IBAction func listBtn_clicked(sender: AnyObject) {
        
        //restrictions on checkin text field
        if checkinRestriction.contains(checkinTxt.text!) {
            print(checkinTxt.text)
        }
        else {
            alert("Incorrect checkin time", message: "Pleas, choose your checkin time from picker")
            return
        }
        
        //data to send to data base
        if ((priceTxt.text?.isEmpty) != nil) {
            alert("Price field is empty", message: "Please, give your listing price. The dault price is 1 euro/dollar")
            priceTxt.text = "1"
            //listing.price = "1"
        }
        listing.price = priceTxt.text!
        
        listing.checkin = checkinTxt.text!
        if daysBtn.backgroundColor == ownColor {
            listing.daysORmonths = "days"
        }
        else {
            listing.daysORmonths = "months"
        }
        listing.hostingPeriod = minValueLbl.text! + "-" + maxValueLbl.text!
        
        print("")
        print(listing.street)
        print(listing.postalCode)
        print(listing.city)
        print(listing.country)
        print(listing.latitude)
        print(listing.longitude)
        
        print("")
        print(listing.listingType)
        print(listing.propertyType)
        
        print("")
        print(listing.rooms)
        print(listing.hostingCapacity)
        print(listing.kitchens)
        print(listing.bathrooms)
        
        print("")
        print(listing.twinBed)
        print(listing.singleBed)
        print(listing.couch)
        print(listing.mattress)
        print(listing.airMattress)
        
        print("")
        print(listing.amenities)
        
        print("")
        print(listing.photos)
        
        print(" ")
        print(listing.price)
        print(listing.checkin)
        print(listing.daysORmonths)
        print(listing.hostingPeriod)
        
        //listing.save()
        
    }
    
    
    
    
}











