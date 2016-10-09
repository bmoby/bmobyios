//
//  registration3stepVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 05/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class registration3stepVC: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedLanguages = [language]()
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** OUTLETS & ACTIONS ***********************************
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    // Avatar outlet ------------------------------------------
    @IBOutlet weak var languagesCollection: UICollectionView!
    
    
    // Nationality & profession & music text fields -----------
    @IBOutlet weak var nationalityTxtF: UITextField!
    @IBOutlet weak var professionTxtF: UITextField!
    @IBOutlet weak var musicTxtF: UITextField!
    
    
    // AboutMe text view --------------------------------------
    @IBOutlet weak var aboutMeTxtV: UITextView!
    
    
    // Submit button ----------------------------------------
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBAction func submitClicked(sender: AnyObject) {
        //ACTION
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        print(self.selectedLanguages)
        
        self.languagesCollection.delegate = self
        self.languagesCollection.dataSource = self
    
     }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ******************************* HELPER METHODS ************************************
    
    
    
    // Method to end the editing and hide the Keyboard
    func hideKeyboard(){
        
        self.view.endEditing(true)
    }
    
    
    // Method to hide the keyboard when the screen is touched
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        hideKeyboard()
    }

    
        
    // -----------------------------------------------------------------------------------
    // ***************************** COLLECTION LANGUAGES ********************************
    
    
    
    // Method to change the input type of the date text field view
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! languageCellVC
        
        cell.langueLbl.text = self.selectedLanguages[indexPath.row].name
        cell.flag.image = self.selectedLanguages[indexPath.row].flag
        
        return cell
    }
    
    // Defining the number of items in a section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.selectedLanguages.count
    }
    
    // Method to remove a selected language
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        // But we need a long press "Methode have to be changed"
        self.selectedLanguages.removeAtIndex(indexPath.row)
        collectionView.reloadData()
    }
    
    
    
    // -----------------------------------------------------------------------------------
    // ***************************** PREPARE FOR SEGUE ***********************************
    
    
    
    // Passing data from current view controller to the languageTVC controller to complete the array
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "backToLanguageSelection" {
            
            let languageTable :languageTVC = segue.destinationViewController as! languageTVC
            languageTable.receivedLanguagesArray = self.selectedLanguages
        }
        
    }

}
