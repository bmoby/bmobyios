//
//  languageTVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 06/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit



class languageTVC: UITableViewController, UISearchResultsUpdating {
    
    
    
    // -----------------------------------------------------------------------------------
    //********************************** VARIBLES  ***************************************
    
    
    
    var userStep3 = user()
    var receivedLanguagesArray = [language]()
    let francais:language = language()
    let anglais:language = language()
    let russe:language = language()
    let italien:language = language()
    let allemand:language = language()
    var languages = [language]()
    var filteredLanguages = [language]()
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    var langue = language()
    

    

    // -----------------------------------------------------------------------------------
    //****************************** DEFAULT METHODS ***********************************
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        
        createLanguages()
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // -----------------------------------------------------------------------------------
    //****************************** TEMPORAIRE METHOD ***********************************
    
    
    
    func createLanguages(){
        
        self.francais.name = "Français"
        self.francais.flag = UIImage(named: "fr")!
        self.anglais.name = "English"
        self.anglais.flag = UIImage(named: "en")!
        self.russe.name = "Russkiy"
        self.russe.flag = UIImage(named: "ru")!
        self.italien.name = "Italiano"
        self.italien.flag = UIImage(named: "it")!
        self.allemand.name = "Deutsch"
        self.allemand.flag = UIImage(named: "de")!
        self.languages.append(self.francais)
        self.languages.append(self.anglais)
        self.languages.append(self.russe)
        self.languages.append(self.italien)
        self.languages.append(self.allemand)
        langListReset()
        
    }
    
    
    // Method that removes the language that hav been already selected from the languages array
    func resetLanguagesList() -> [String]{
        var newArray = [String]()
        for langue in self.userStep3.languages {
            
            newArray.append(langue.name)
        }
        
        return newArray
    }
    
    func resetLanguagesList2() -> [String]{
        var newArray = [String]()
        for langue in self.languages {
            
            newArray.append(langue.name)
        }
        
        return newArray
    }
    
    func langListReset() {
        let myarray = self.resetLanguagesList()
        for lang in self.languages{
            if myarray.contains(lang.name){
                let myarray2 = self.resetLanguagesList2()
                let index = myarray2.indexOf(lang.name)
                self.languages.removeAtIndex(index!)
            } else {
                
            }
        }
    }
    
    
    // -----------------------------------------------------------------------------------
    //*************************** SEARCH RESULT METHOD ***********************************
    
    
    
    // This method fires when the user tape something in the searchBar at the top
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        // Filter the array with languages
        self.filteredLanguages = self.languages.filter ({ (language:language) -> Bool in
            if language.name.containsString(self.searchController.searchBar.text!){
            
                return true
                
            } else {
            
                return false
            }
        })
        
        // Update the results tableview
        self.resultsController.tableView.reloadData()
    }

    
    
    // -----------------------------------------------------------------------------------
    //***************************** TABLE VIEW METHODS ***********************************
    
    
    
    // Method to specify the number of sections in the table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    // Method to specify the number of items in a section (languages and flags in our case)
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == self.tableView {
            
            return self.languages.count
        } else {
            
            return self.filteredLanguages.count
        }
    }
    
    
    // Method who fires when a cell is selected in the table view
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.langue.name = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!
        self.langue.flag = (tableView.cellForRowAtIndexPath(indexPath)?.imageView?.image)!
        if tableView != self.resultsController.tableView {
            
            self.performSegueWithIdentifier("languageSelected", sender: nil)
            
        } else {
            
            dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("languageSelected", sender: nil)
        }
    }
    
    
    // This function creates the cells and put info into it
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if tableView == self.tableView {
            cell.textLabel?.text = self.languages[indexPath.row].name
            cell.imageView?.image = self.languages[indexPath.row].flag
        } else {
            
            cell.textLabel?.text = self.filteredLanguages[indexPath.row].name
            cell.imageView?.image = self.filteredLanguages[indexPath.row].flag
        }
        
        return cell
    }

    
    
    // -----------------------------------------------------------------------------------
    //************************* SEGUE METHODS PASSING DATA *******************************
    
    
    
    // This guy takes some information in the actual controller and send it to another one
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "languageSelected" {
            
        let registration3step :registration3stepVC = segue.destinationViewController as! registration3stepVC
        self.userStep3.languages.append(self.langue)
        registration3step.userStep3 = self.userStep3
        }
    }
}
