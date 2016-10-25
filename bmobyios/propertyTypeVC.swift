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
//---------------------------------------------------------------------------------------------------
//***************************************** DEFAULT *************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        
        //initializing table
        tableView.delegate = self
        tableView.dataSource = self
        
        ///cell height
        self.tableView.rowHeight = 68
        
        
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
        
        
        return cell
    }
    
    
    // going to the next controller and managing data 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as? propertyTypeCell
        
        if cell?.accessoryType != nil {
            
            // data to send to database
            createListingPropertyType.propertyType = (cell?.propertyTypeLbl?.text)!
            //listing.propertyType = (cell?.propertyTypeLbl?.text)!
            
            // going to the next controller: VC listingInfo1VC
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo1VC") as! listingInfo1VC
            self.navigationController?.pushViewController(next, animated: true)
            next.createListingInfo1 = createListingPropertyType
            
        }
    }
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back: listingInfo2VC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingTypeVC") as! listingTypeVC
        self.navigationController?.pushViewController(next, animated: true)
        next.createListingType = createListingPropertyType

    }

}
