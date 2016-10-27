//
//  backofficeVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/20/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class backofficeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//-------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    
    var iconImg = [UIImage(named: "fr"), UIImage(named: "it"), UIImage(named: "en"), UIImage(named: "de")]
    var titleLbl = ["My profile", "My listings", "Create listing", "Options"]
    
    
    
//--------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ************************************************

    @IBOutlet var tableView: UITableView!
    
//--------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
//---------------------------------------------------------------------------------------------------
//***************************************** TABLE ***************************************************

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleLbl.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("backofficeVC", forIndexPath: indexPath) as! backofficeCell
        
        cell.imageView?.image = iconImg[indexPath.row]
        cell.lbl.text = titleLbl[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! backofficeCell
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if cell.lbl.text == "Create listing" {
            // defining the storyboard, navigation controller, and adresssMapVC
            let storyBoard = UIStoryboard(name: "createListing", bundle: nil)
            let next = storyBoard.instantiateViewControllerWithIdentifier("adressMapVC") as! adressMapVC
            
            //presenting the adressMapVC through navigationController
            self.presentViewController(next, animated: true, completion: nil)

        }
        else if cell.lbl.text == "My listings"{
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("myListingsVC") as! myListingsVC
            self.presentViewController(next, animated: true, completion: nil)
        }

                /*
        if cell.lbl?.text == "Edit profle" {
            //let next = self.storyboard?.instantiateViewControllerWithIdentifier("editProfileVC") as! editProfileVC
            //self.navigationController?.pushViewController(next, animated: true)
        }
        else if cell.lbl.text == "Edit listing"{
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("editListingVC") as! editListingVC
            self.navigationController?.pushViewController(next, animated: true)
        }
        else if cell.lbl.text == "Create listing" {
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("adressMapVC") as! adressMapVC
            self.navigationController?.pushViewController(next, animated: true)
        }
        else {
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("optionsVC") as! optionsVC
            self.navigationController?.pushViewController(next, animated: true)
        } */
        
    }

}

class backofficeCell: UITableViewCell {
    
    @IBOutlet var iconImg: UIImageView!
    @IBOutlet var lbl: UILabel!
}
