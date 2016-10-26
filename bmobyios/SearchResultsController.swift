//
//  cityCell.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 23/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

// Declaring protocol to send info to checkVC who automaticly will send it to homePageVC if exists
protocol PassDataToCheckVC {
    
    func selectedCityInSearchBar(data: String)
}

class SearchResultsController: UITableViewController {
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* SEGUES AND VARS ************************************
    
    
    
    var delegate:PassDataToCheckVC? = nil
    var searchResults: [String]!
    var selectedCityName:String?
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.searchResults = Array()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************** TABLE METHODS *************************************
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResults.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
            cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedCityName = self.searchResults[indexPath.row]
        if self.delegate != nil {
            
            let data = searchResults[indexPath.row]
            delegate?.selectedCityInSearchBar(data)
        }else{
            
            print("SearchResultsController: SearchResults delegate is nil, cant pass data!")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************** HELPER METHODS ************************************
    
    
    
    func reloadDataWithArray(array:[String]){
        
        self.searchResults = array
        self.tableView.reloadData()
    }
}