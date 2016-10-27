//
//  listingTypeVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/11/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class listingTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//-------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    
    var id = String()
    var controller = String()
    
    var createListingType = listingClass()
    
    // listing type array to display on table cells
    var listingTypeArray = ["Shared room", "Private room", "Entire place"]
    var listingTypeIconArray = [UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon")]
    

    
//--------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ************************************************
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet var backBtn: UIButton!
    @IBOutlet var doNotUpdateBtn: UIButton!
    
//--------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        //initializing table
        tableView.delegate = self
        tableView.dataSource = self
        
        //cell height
        self.tableView.rowHeight = 68
        
        // hide and show buttons dependng on previous controller
        if controller == "myListngVC" {
            backBtn.hidden = true
            
            doNotUpdateBtn.hidden = false
        }
        else {
            backBtn.hidden = false
            
            doNotUpdateBtn.hidden = true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//---------------------------------------------------------------------------------------------------
//***************************************** TABLE ***************************************************

    // number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // cells confniguration
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listingTypeCell", forIndexPath: indexPath) as! listingTypeCell
        
        cell.listingTypeLbl.text = listingTypeArray[indexPath.row]
        cell.listingTypeImg.image = listingTypeIconArray[indexPath.row]
        
        return cell
    }
    
    // select a row and do an action
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as? listingTypeCell
        
        
        if cell?.accessoryType != nil {
            
            // data to send to database
            createListingType.listingType = (cell?.listingTypeLbl.text)!
            
            // going to the next controller: TVC of property type
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("propertyTypeVC") as! propertyTypeVC
            next.createListingPropertyType = createListingType
            next.id = self.id
            next.controller = self.controller
            self.presentViewController(next, animated: true, completion: nil)
        }
    }
    
    

//-------------------------------------------------------------------------------------------------
//************************************** GOING BACK  **********************************************
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back: listingInfo2VC
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("adressMapVC") as! adressMapVC
        back.createListingAdress = createListingType
        
        self.presentViewController(back, animated: true, completion: nil)

        
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





















