//
//  myListingsVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/21/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Parse

class myListingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

//-------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    
    var id = [String]()
    var price = [String]()
    var mainPhoto = [PFFile]()
    var fullAdress = [String]()


    
//--------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ************************************************
    
    @IBOutlet var tableView: UITableView!
    

    
//--------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
       loadMyListings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadMyListings() {
        // to add: if statement to check if user has or not a listing and alert message if does not
        let query = PFQuery(className: "listing")
        query.whereKey("uuid", equalTo: "1")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                
                self.id.removeAll(keepCapacity: false)
                self.price.removeAll(keepCapacity: false)
                self.fullAdress.removeAll(keepCapacity: false)
                
                // photo
                self.mainPhoto.removeAll(keepCapacity: false)
                
                
                self.fullAdress.removeAll(keepCapacity: false)
                
                for object in objects! {
                    self.id.append(object.objectId!)
                    self.price.append(object.valueForKey("price") as! String)
                    self.fullAdress.append(object.valueForKey("fullAdress") as! String)
                    self.mainPhoto.append(object.valueForKey("mainPhoto") as! PFFile)
                    
                    self.tableView.reloadData()
                }
            }
            else {
                print(error?.localizedDescription)
            }
        }
        
    }
    


//---------------------------------------------------------------------------------------------------
//***************************************** TABLE ***************************************************
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  price.count
    }
    
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // defining cell
        let cell = tableView.dequeueReusableCellWithIdentifier("myListingsCell", forIndexPath: indexPath) as! myListingsCell
        
        mainPhoto[indexPath.row].getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
            if error == nil {
                cell.mainPothoImg.image = UIImage(data: data!)
            }
        }
        cell.listingPriceLbl.text = self.price[indexPath.row]
        cell.listingAdressTxt.text = self.fullAdress[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let next = storyboard?.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
        self.navigationController?.pushViewController(next, animated: true)
        
        // transporting data to the next controller
        next.id = self.id[indexPath.row]
    }
    
}



class myListingsCell: UITableViewCell {
    
    @IBOutlet var mainPothoImg: UIImageView!
    @IBOutlet var listingPriceLbl: UILabel!
    @IBOutlet var listingAdressTxt: UITextView!
    
}
