//
//  propertyType.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/11/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class propertyTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
//-------------------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ***************************************************
    var propertyTypeArray = ["Apartment","House","Dorm","Villa","Townhouse","Treehouse","RV","Chalet","Castle","Boat","Loft","Bungalow","Cabin","Plane","Lighthouse","Tipi","Yurt","Cave","Tent","Earthhouse","Hut","Train","Other"]
    

    
//-------------------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ***********************************************************
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
//-------------------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    


//-------------------------------------------------------------------------------------------------------------
//***************************************** TABLE *************************************************************
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
        cell.propertyTypeImg.image = UIImage(named: "adressIcon")
        
        
        
        return cell
    }
    

  
    

}
