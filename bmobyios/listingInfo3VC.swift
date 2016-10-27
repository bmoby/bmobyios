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
    
    var createListingFinal = listingClass()
    
    // listing id to update the photos and controller to show the update buttons
    var id = String()
    var controller = String()
    
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
    
    
    //checkin pickerview and picker data
    var hour:String = ""
    var minute:String = ""
    var checkinPicker: UIPickerView!
    var checkinData = [["any hour","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"], ["any minute","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"] ]
    
//-------------------------------------------------------------------------------------------------------
//***************************************** OUTLETS *****************************************************
    // scroll view
    @IBOutlet var scrollView: UIScrollView!
    
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
    @IBOutlet var minValueTxt: UITextField!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet var maxValueTxt: UITextField!
    
    //checkin time
    @IBOutlet weak var checkinHeaderLbl: UILabel!
    @IBOutlet weak var checkinTxt: UITextField!
        
    // list button
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var doNotUpdateBtn: UIButton!
    
//------------------------------------------------------------------------------------------------------
//***************************************** DEFAULT *****************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        
        //scroll view
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height
        
        //check notification if keyboard shown or not
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(listingInfo3VC.showKeyboard(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(listingInfo3VC.hideKeyboard(_:)), name: UIKeyboardDidHideNotification, object: nil)
        
        // tap to hide the keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(listingInfo3VC.hideTap))
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        
        //numeric keyboard for price and days/months valuestext field
        priceTxt.delegate = self
        priceTxt.keyboardType = UIKeyboardType.NumberPad
        minValueTxt.delegate = self
        minValueTxt.keyboardType = UIKeyboardType.NumberPad
        maxValueTxt.delegate = self
        maxValueTxt.keyboardType = UIKeyboardType.NumberPad
        
        
        //checkin picker
        checkinPicker = UIPickerView()
        checkinPicker.dataSource = self
        checkinPicker.delegate = self
        checkinPicker.backgroundColor = UIColor.groupTableViewBackgroundColor()
        checkinPicker.showsSelectionIndicator = true
        checkinTxt.inputView = checkinPicker
        
        //--------------------------------- complete view fields listingClass values are not empty
        if createListingFinal.price.isEmpty == false {
            priceTxt.text = createListingFinal.price
        }
        if createListingFinal.checkin.isEmpty == false {
            checkinTxt.text = createListingFinal.checkin
        }
        if createListingFinal.daysORmonths.isEmpty == false {
            if createListingFinal.daysORmonths == "days" {
                daysBtn.backgroundColor = ownColor
                monthsBtn.backgroundColor = grayColor
            }
            else {
                daysBtn.backgroundColor = grayColor
                monthsBtn.backgroundColor = ownColor
            }
        }
        if createListingFinal.hostingPeriodMin.isEmpty == false {
            minValueTxt.text = createListingFinal.hostingPeriodMin
        }
        if createListingFinal.hostingPeriodMax.isEmpty == false {
            maxValueTxt.text = createListingFinal.hostingPeriodMax
        }
        if minValueTxt.text! == "1" && createListingFinal.hostingPeriodMin.isEmpty == false {
            
        }
        
        
        // hide and show buttons dependng on previous controller
        if controller == "myListngVC" {
            listBtn.hidden = true
            backBtn.hidden = true
            
            updateBtn.hidden = false
            doNotUpdateBtn.hidden = false
        }
        else {
            listBtn.hidden = false
            backBtn.hidden = false
            
            updateBtn.hidden = true
            doNotUpdateBtn.hidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
//------------------------------------------------------------------------------------------------------
//***************************************** KEYBOARD ***************************************************
    
    // hide the keyboard
    func hideTap() {
        self.view.endEditing(true)
    }
    
    var xScroll = CGPoint()
    var yScroll = CGPoint()
    
    //show keyboard function
    func showKeyboard(notification:NSNotification) {
        
        //define keyboard size
        keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]!.CGRectValue)!
        
        //move up UI
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollView.frame = CGRectMake(0, -self.keyboard.height + 100, self.scrollViewHeight - self.keyboard.height, self.view.frame.size.height)
            self.scrollView.contentSize.height = self.view.frame.height
            self.scrollViewHeight = self.scrollView.frame.size.height
        }
    }
    
    //hide keyboard function
    func hideKeyboard(notification:NSNotification) {
        
        //move down UI
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
            self.scrollView.contentSize.height = self.view.frame.height
            self.scrollViewHeight = self.scrollView.frame.size.height
        }
    }
    
    
    
//------------------------------------------------------------------------------------------------------
//***************************************** DYAS/MONTHS ************************************************
    
    // user chooses to host for some days
    @IBAction func daysBtn_clicked(sender: AnyObject) {
        daysBtn.backgroundColor = ownColor
        monthsBtn.backgroundColor = grayColor
        daysORmonths = "days"

    }
    
    // user chooses to host for some months
    @IBAction func monthsBtn_clicked(sender: AnyObject) {
        daysBtn.backgroundColor = grayColor
        monthsBtn.backgroundColor = ownColor
        daysORmonths = "months"
        
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
        
        // uuid
        createListingFinal.uuid = "1"
        
        // days or months data
        if daysBtn.backgroundColor == ownColor {
            createListingFinal.daysORmonths = "days"
        }
        else {
            createListingFinal.daysORmonths = "months"
        }
        
        if priceTxt.text == "" {
            alert("Price field is empty", message: "Please, give your listing price. The dault price is 1 euro/dollar")
            priceTxt.text = "1"
        }
        else if minValueTxt.text == ""{
            // min days/months value
            alert("Min days field is empty", message: "Please, define min vaule. The dault min value is 1")
            minValueTxt.text = "1"
            
        }
        else if maxValueTxt.text == "" {
            // max days/months value
            alert("Max days field is empty", message: "Please, define max vaule. The dault min value is 100000")
            maxValueTxt.text = "100000"
        }
        else if Int(minValueTxt.text!) > Int(maxValueTxt.text!) {
            alert("Min days/months can not be more than max days/months field is empty", message: "The dault min values are 1 and 100000")
            minValueTxt.text = "1"
            maxValueTxt.text = "100000"
        }
        else {
            createListingFinal.price = priceTxt.text!
            createListingFinal.checkin = checkinTxt.text!
            createListingFinal.hostingPeriod = minValueTxt.text! + "-" + maxValueTxt.text!
            
            // send and save data
            createListingFinal.save()
            
        }
        
    }
    
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        
        // days or months data
        if daysBtn.backgroundColor == ownColor {
            createListingFinal.daysORmonths = "days"
        }
        else {
            createListingFinal.daysORmonths = "months"
        }
        
        createListingFinal.price = priceTxt.text!
        createListingFinal.checkin = checkinTxt.text!
        createListingFinal.hostingPeriodMin = minValueTxt.text!
        createListingFinal.hostingPeriodMax = maxValueTxt.text!
        createListingFinal.hostingPeriod = minValueTxt.text! + "-" + maxValueTxt.text!
        
        // going back: listingPhotosVC
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("listingPhotosVC") as! listingPhotosVC
        back.createListingPhotos = createListingFinal
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    
    
    
//-------------------------------------------------------------------------------------------------
//**************************** UPDATING THE LISTING PRICE, CHECKIN AND HOSTING PERIOD *************
    
    @IBAction func updateBtn_clicked(sender: AnyObject) {
        
        // uuid
        createListingFinal.uuid = "1"
        
        // days or months data
        if daysBtn.backgroundColor == ownColor {
            createListingFinal.daysORmonths = "days"
        }
        else {
            createListingFinal.daysORmonths = "months"
        }
        
        if priceTxt.text == "" {
            alert("Price field is empty", message: "Please, give your listing price. The dault price is 1 euro/dollar")
            priceTxt.text = "1"
        }
        else if minValueTxt.text == ""{
            // min days/months value
            alert("Min days field is empty", message: "Please, define min vaule. The dault min value is 1")
            minValueTxt.text = "1"
            
        }
        else if maxValueTxt.text == "" {
            // max days/months value
            alert("Max days field is empty", message: "Please, define max vaule. The dault min value is 100000")
            maxValueTxt.text = "100000"
        }
        else if Int(minValueTxt.text!) > Int(maxValueTxt.text!) {
            alert("Min days/months can not be more than max days/months field is empty", message: "The dault min values are 1 and 100000")
            minValueTxt.text = "1"
            maxValueTxt.text = "100000"
        }
        else {
            createListingFinal.price = priceTxt.text!
            createListingFinal.checkin = checkinTxt.text!
            createListingFinal.hostingPeriod = minValueTxt.text! + "-" + maxValueTxt.text!
            
            
            let query = PFQuery(className: "listing")
            query.getObjectInBackgroundWithId(self.id) {(object: PFObject?, error: NSError?) in
                
                if error == nil {
                    
                    object?.setValue(self.createListingFinal.price, forKey: "price")
                    object?.setValue(self.createListingFinal.checkin, forKey: "checkin")
                    object?.setValue(self.createListingFinal.daysORmonths, forKey: "daysORmonths")
                    object?.setValue(self.createListingFinal.hostingPeriod, forKey: "hostingPeriod")
                    
                    object?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                        if error == nil {
                            let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
                            let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
                            back.id = self.id
                            self.presentViewController(back, animated: true, completion: nil)
                            
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

    }
    
    
    
//-------------------------------------------------------------------------------------------------
//*********************** GOING BACK TO THE myListingVC: no update ********************************
    @IBAction func doNotUpdateBtn_clicked(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
        back.id = self.id
        self.presentViewController(back, animated: true, completion: nil)
        print("let me go back")
    }
    
}

    











