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
//***************************************** LOCAL VARIABLES ****************************************
    var listingPhotos = [PFFile]()
    
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
}

//-------------------------------------------------------------------------------------------------
//***************************************** CELL CLASS ********************************************

class fullScreenPhotoCell: UICollectionViewCell {
    @IBOutlet var img: UIImageView!
}

