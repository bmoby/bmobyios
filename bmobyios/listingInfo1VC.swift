//
//  listingInfo1VCViewController.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/19/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class listingInfo1VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //--------------------------------------------------------------------------------------------------
    //***************************************** LOCAL VARIABLES ****************************************
    private var collectionViewLayout: LGHorizontalLinearFlowLayout!
    
    // sting array rooms and hosting capacity
    var stringArray: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30+"]
    
    // sting array rooms and hosting capacity
    var stringArray2: [String] = ["0","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29+"]
    
    var selectedCell: Int! = 0
    
    // data to send to database
    var room = String()
    var hostingCapacity = String()
    var kitchen = String()
    var bathroom = String()
    
    //-------------------------------------------------------------------------------------------------
    //***************************************** OUTLETS ***********************************************
    @IBOutlet var listingInfo1View: UIView!
    @IBOutlet var listingInfo1Lbl: UILabel!
    
    // room header and collecetiov view
    @IBOutlet var roomLbl: UILabel!
    @IBOutlet var collectionViewRoom: UICollectionView!
    
    //hosting capacity header and collection view
    @IBOutlet var hostingCapacityLbl: UILabel!
    @IBOutlet var collectioViewHostingCapacity: UICollectionView!
    
    //couch header and collection view
    @IBOutlet var kitchenLbl: UILabel!
    @IBOutlet var collectionViewKitchen: UICollectionView!
    
    //couch header and collection view
    @IBOutlet var bathroomLbl: UILabel!
    @IBOutlet var collectionViewBathroom: UICollectionView!
    
    //button to go to the next controller
    @IBOutlet var nextBtn: UIButton!
    
    
    //-------------------------------------------------------------------------------------------------
    //***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        collectionViewRoom.delegate = self
        collectioViewHostingCapacity.delegate = self
        collectionViewKitchen.delegate = self
        collectionViewBathroom.delegate = self
     
        
        // data source
        collectionViewRoom.dataSource = self
        collectioViewHostingCapacity.dataSource = self
        collectionViewKitchen.dataSource = self
        collectionViewBathroom.dataSource = self
        
        
        // scroll indicator
        collectionViewRoom.showsHorizontalScrollIndicator = false
        collectioViewHostingCapacity.showsHorizontalScrollIndicator = false
        collectionViewKitchen.showsHorizontalScrollIndicator = false
        collectionViewBathroom.showsHorizontalScrollIndicator = false
        
        
        
        // paging
        collectionViewRoom.pagingEnabled = false
        collectioViewHostingCapacity.pagingEnabled = false
        collectionViewKitchen.pagingEnabled = false
        collectionViewBathroom.pagingEnabled = false
        
        
        
        // cells size
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewRoom, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectioViewHostingCapacity, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewKitchen, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewBathroom, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        
        selectedCell = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------------------------------------------------------------------------------------------------
    //********************************* CELLS CONFIG  **************************************************
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! collectionViewCell
        
        if collectionView == collectionViewRoom || collectionView == collectioViewHostingCapacity {
            cell.lbl.text = stringArray[indexPath.row]
        }
        else {
            cell.lbl.text = stringArray2[indexPath.row]
        }
        
        //cell.lbl.text = stringArray[indexPath.row]
        cell.lbl.textColor = UIColor.greenColor()
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return cell
        
    }
    
    
    
    //****************************************************************************************************
    //------------------------ CALL FUNCTIONS WHEN SCROLL VIEW SCROLLED  ---------------------------------
    func scrollViewDidScroll(scrollView: UIScrollView) {
        findCenterIndexRoom(scrollView)
        findCenterIndexHostingCapacity(scrollView)
        findCenterIndexKitchen(scrollView)
        findCenterIndexBathroom(scrollView)
    }
    
    
    
    //****************************************************************************************************
    //------------------------ Room: getting central value of collection view ------------------------
    
    func findCenterIndexRoom(scrollView: UIScrollView) {
        //create CGPoint to position the first cell
        let collectionOrigin = collectionViewRoom!.bounds.origin
        let collectionWidth = collectionViewRoom!.bounds.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        // get the data from CGPoint position (central one) to send data base
        let index = collectionViewRoom!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewRoom.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewRoom.indexPathForCell(cell!)?.item
                self.room = stringArray[selectedCell!]
            }
        }
    }
    
    
    
    //****************************************************************************************************
    //----------------- HostingCapacity: getting central value of collection view ------------------------
    
    func findCenterIndexHostingCapacity(scrollView: UIScrollView) {
        let collectionOrigin = collectioViewHostingCapacity!.bounds.origin
        let collectionWidth = collectioViewHostingCapacity!.bounds.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        let index = collectioViewHostingCapacity!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectioViewHostingCapacity.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectioViewHostingCapacity.indexPathForCell(cell!)?.item
                self.hostingCapacity = stringArray[selectedCell!]
            }
        }
    }
    
    
    
    //***************************************************************************************************
    //--------------------------- Couch: getting central value of collection view -----------------------
    
    func findCenterIndexKitchen(scrollView: UIScrollView) {
        let collectionOrigin = collectionViewKitchen!.bounds.origin
        let collectionWidth = collectionViewKitchen!.bounds.width
        // let collectionOrigin = collectionViewKitchen!.frame.origin
        // let collectionWidth = collectionViewKitchen!.frame.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        let index = collectionViewKitchen!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewKitchen.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewKitchen.indexPathForCell(cell!)?.item
                self.kitchen = stringArray2[selectedCell!]
            }
        }
    }
    
    
    
    //****************************************************************************************************
    //------------------------  Matress: getting central value of collection view ------------------------
    
    func findCenterIndexBathroom(scrollView: UIScrollView) {
        let collectionOrigin = collectionViewBathroom!.bounds.origin
        let collectionWidth = collectionViewBathroom!.bounds.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        let index = collectionViewBathroom!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewBathroom.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewBathroom.indexPathForCell(cell!)?.item
                self.bathroom = stringArray2[selectedCell!]
            }
        }
    }

    
    
    
    //****************************************************************************************************
    //-----------------------------------  SEND DATA TO DATABASE -----------------------------------------
    @IBAction func nextBtn_clicked(sender: AnyObject) {
        
        //the dafault value to send to database
        if room.isEmpty && hostingCapacity.isEmpty && kitchen.isEmpty && bathroom.isEmpty {
            // if user touch at least one collection view, the celle values are recognized otherwise set them to 0:
            room = "1"
            hostingCapacity = "1"
            kitchen = "0"
            bathroom = "0"
            
            print("")
            print(room)
            print(hostingCapacity)
            print(kitchen)
            print(bathroom)
            
            
        }
        
        //send data
            
        listing.rooms = room
        listing.hostingCapacity = hostingCapacity
        listing.kitchens = kitchen
        listing.bathrooms = bathroom
        
        print("")
        print(listing.rooms)
        print(listing.hostingCapacity)
        print(listing.kitchens)
        print(listing.bathrooms)
            
        // going to next controller: listingAmenitiesVC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo2VC") as?listingInfo2VC
        self.navigationController?.pushViewController(next!, animated: true)
        
    }
}

class collectionViewCell: UICollectionViewCell {
    @IBOutlet var lbl: UILabel!
    
}
