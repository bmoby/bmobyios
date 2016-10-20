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
  
    // listing type array to display on table cells
    var listingTypeArray = ["Shared room", "Private room", "Entire place"]
    var listingTypeIconArray = [UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon")]
    

    
//--------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ************************************************
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet var backBtn: UIButton!
    
//--------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initializing table
        tableView.delegate = self
        tableView.dataSource = self
        
        //cell height
        self.tableView.rowHeight = 68

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//---------------------------------------------------------------------------------------------------
//***************************************** TABLE ***************************************************
    /*
    // number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    } */

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
    
    // !!!!!!!!!!!!
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as? listingTypeCell
        
        
        if cell?.accessoryType != nil {
            
            // data to send to database
            listing.listingType = (cell?.listingTypeLbl.text)!
            
            // going to the next controller: TVC of property type
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("propertyTypeVC") as! propertyTypeVC
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back: listingInfo2VC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("adressMapVC") as! adressMapVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}





















