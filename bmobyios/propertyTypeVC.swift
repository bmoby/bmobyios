//
//  propertyType.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/11/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class propertyTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//-----------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES *******************************************
    
    var id = String()
    var controller = String()
    
    var createListingPropertyType = listingClass()
    //property type variable to send to database
    var propertyType = String()
    
    // property type array to display on table cells
    var propertyTypeArray = ["Apartment","House","Dorm","Villa","Townhouse","Treehouse","RV","Chalet","Castle","Boat","Loft","Bungalow","Cabin","Plane","Lighthouse","Tipi","Yurt","Cave","Tent","Earthhouse","Hut","Train","Other"]
    var propertyTypeIconArray = [UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon")]

    
    
//---------------------------------------------------------------------------------------------------
//***************************************** OUTLETS *************************************************
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var backBtnUpdate: UIButton!
    
    
    
//---------------------------------------------------------------------------------------------------
//***************************************** DEFAULT *************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
                
        //initializing table
        tableView.delegate = self
        tableView.dataSource = self
        
        ///cell height
        self.tableView.rowHeight = 68
        
        // hide and show buttons dependng on previous controller
        if controller == "myListngVC" {
            backBtn.hidden = true
            
            updateBtn.hidden = false
            backBtnUpdate.hidden = false
            
        }
        else {
            backBtn.hidden = false
            
            updateBtn.hidden = true
            backBtnUpdate.hidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


//-------------------------------------------------------------------------------------------------
//***************************************** TABLE *************************************************
    // number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyTypeArray.count
    }
    
    
    // cells configuration
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("propertyTypeCell", forIndexPath: indexPath) as! propertyTypeCell
        
        cell.propertyTypeLbl.text = propertyTypeArray[indexPath.row]
        cell.propertyTypeImg.image = propertyTypeIconArray[indexPath.row]
        
        if self.controller != "myListngVC" {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        
        return cell
    }
    
    
    
//------------------------------------------------------------------------------------------------
//************************************ GOING TO NEXT VC: listingInfo1VC **************************
    
    // going to the next controller and managing data 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as? propertyTypeCell
        
        if cell?.accessoryType != nil {
            
            if self.controller != "myListngVC" {
                // data to send to database
                createListingPropertyType.propertyType = (cell?.propertyTypeLbl?.text)!
                
                // going to the next controller: VC listingInfo1VC
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo1VC") as! listingInfo1VC
                next.createListingInfo1 = createListingPropertyType

                self.presentViewController(next, animated: true, completion: nil)
            }
            else {
                cell?.backgroundColor = UIColor.clearColor()
                createListingPropertyType.propertyType = (cell?.propertyTypeLbl?.text)!
            }
        }
    }

    
    
//-------------------------------------------------------------------------------------------------
//************************************** GOING BACK TO listingTypeVC ******************************
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("listingTypeVC") as! listingTypeVC
        back.createListingType = createListingPropertyType
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//*********************************** UPDATING THE LISTING AND PROPERTY TYPES *********************
    
    @IBAction func updateBtn_clicked(sender: AnyObject) {
        
        let query = PFQuery(className: "listing")
        query.getObjectInBackgroundWithId(self.id) {(object: PFObject?, error: NSError?) in
            
            if error == nil {
                object?.setValue(self.createListingPropertyType.listingType, forKey: "listingType")
                object?.setValue(self.createListingPropertyType.propertyType, forKey: "propertyType")

        
                object?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                    if error == nil {
                        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
                        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
                        back.id = self.id
                        self.presentViewController(back, animated: true, completion: nil)
                        
                        print("listing and property types have been successfully updated")
                        
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
    @IBAction func backBtnUpdate_clicked(sender: AnyObject) {
        
        // going back
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("listingTypeVC") as! listingTypeVC
        back.id = self.id
        back.controller = self.controller
        self.presentViewController(back, animated: true, completion: nil)
    }
    
    
    

}
