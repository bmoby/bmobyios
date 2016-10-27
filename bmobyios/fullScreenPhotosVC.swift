//
//  fullScreenPhotosVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/24/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class fullScreenPhotosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

//-------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ***************************************
    var id = String()
    var listingPhotos = [PFFile]()
    
    @IBOutlet var backBtn: UIButton!
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.hidden = true
        
        // to eliminate the layout errors
        self.automaticallyAdjustsScrollViewInsets = false
        
        // initilise collection view
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** CONFIFURE CELLS ***************************************
    // setting the spaces between cells to 0 to center cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat { return 0
    }
    
    
    // number of items
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listingPhotos.count
    }
    
    
    // data source of collection view
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("fullScreenPhotoCell", forIndexPath: indexPath) as! fullScreenPhotoCell
        listingPhotos[indexPath.row].getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
            if error == nil {
                cell.img.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** GO BACK TO myListingVC ********************************
    @IBAction func backBtn_clicked(sender: AnyObject) {
        let next = storyboard?.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
        next.id = self.id
        self.presentViewController(next, animated: true, completion: nil)
    }
}



//-------------------------------------------------------------------------------------------------
//***************************************** CELL CLASS ********************************************

class fullScreenPhotoCell: UICollectionViewCell {
    @IBOutlet var img: UIImageView!
}






