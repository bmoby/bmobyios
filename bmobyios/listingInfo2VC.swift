//
//  listingInfo3VC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/12/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class listingInfo2VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
//--------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    private var collectionViewLayout: LGHorizontalLinearFlowLayout!
    
    // sting array rooms and hosting capacity
    var stringArray: [String] = ["0","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30+"]
    
    var selectedCell: Int! = 0
    
    // data to send to database
    var twinBed = String()
    var singleBed = String()
    var couch = String()
    var matress = String()
    var airMatress = String()

//-------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ***********************************************
    
    // twin bed header and collecetiov view
    @IBOutlet var twinBedHeaderLbl: UILabel!
    @IBOutlet var collectionViewTwinBed: UICollectionView!
    
    //single bed header and collection view
    @IBOutlet var singleBedHeaderLbl: UILabel!
    @IBOutlet var collectioViewSingleBed: UICollectionView!
    
    //couch header and collection view
    @IBOutlet var couchHeaderLbl: UILabel!
    @IBOutlet var collectionViewCouch: UICollectionView!
    
    //couch header and collection view
    @IBOutlet var matressHeaderLbl: UILabel!
    @IBOutlet var collectionViewMatress: UICollectionView!
    
    //couch header and collection view
    @IBOutlet var airMatressHeaderLbl: UILabel!
    @IBOutlet var collectionViewAirMatress: UICollectionView!
    
    //button to go to the next controller
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var backBtn: UIButton!

//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        collectionViewTwinBed.delegate = self
        collectioViewSingleBed.delegate = self
        collectionViewCouch.delegate = self
        collectionViewMatress.delegate = self
        collectionViewAirMatress.delegate = self
        
        // data source
        collectionViewTwinBed.dataSource = self
        collectioViewSingleBed.dataSource = self
        collectionViewCouch.dataSource = self
        collectionViewMatress.dataSource = self
        collectionViewAirMatress.dataSource = self
        
        // scroll indicator
        collectionViewTwinBed.showsHorizontalScrollIndicator = false
        collectioViewSingleBed.showsHorizontalScrollIndicator = false
        collectionViewCouch.showsHorizontalScrollIndicator = false
        collectionViewMatress.showsHorizontalScrollIndicator = false
        collectionViewAirMatress.showsHorizontalScrollIndicator = false

        
        // paging
        collectionViewTwinBed.pagingEnabled = false
        collectioViewSingleBed.pagingEnabled = false
        collectionViewCouch.pagingEnabled = false
        collectionViewMatress.pagingEnabled = false
        collectionViewAirMatress.pagingEnabled = false

        
        // cells size
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewTwinBed, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectioViewSingleBed, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewCouch, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewMatress, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        self.collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(self.collectionViewAirMatress, itemSize: CGSizeMake(32, 32), minimumLineSpacing: 10)
        
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
        
        cell.lbl.text = stringArray[indexPath.row]
        cell.lbl.textColor = UIColor.greenColor()
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return cell
        
    }
    
    
    
//****************************************************************************************************
//------------------------ CALL FUNCTIONS WHEN SCROLL VIEW SCROLLED  ---------------------------------
    func scrollViewDidScroll(scrollView: UIScrollView) {
        findCenterIndexTwinBed(scrollView)
        findCenterIndexSingleBed(scrollView)
        findCenterIndexCouch(scrollView)
        findCenterIndexMatress(scrollView)
        findCenterIndexAirMatress(scrollView)
    }
    
    
    
//****************************************************************************************************
//------------------------ Twin Bed: getting central value of collection view ------------------------
    
    func findCenterIndexTwinBed(scrollView: UIScrollView) {
        //create CGPoint to position the first cell
        let collectionOrigin = collectionViewTwinBed!.bounds.origin
        let collectionWidth = collectionViewTwinBed!.bounds.width
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
        let index = collectionViewTwinBed!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewTwinBed.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewTwinBed.indexPathForCell(cell!)?.item
                self.twinBed = stringArray[selectedCell!]
            }
        }
    }
    
    
    
//****************************************************************************************************
//------------------- Single Bed: getting central value of collection view ---------------------------
    
    func findCenterIndexSingleBed(scrollView: UIScrollView) {
        let collectionOrigin = collectioViewSingleBed!.bounds.origin
        let collectionWidth = collectioViewSingleBed!.bounds.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        let index = collectioViewSingleBed!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectioViewSingleBed.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectioViewSingleBed.indexPathForCell(cell!)?.item
                self.singleBed = stringArray[selectedCell!]
            }
        }
    }
    
    
    
//***************************************************************************************************
//--------------------------- Couch: getting central value of collection view -----------------------
    
    func findCenterIndexCouch(scrollView: UIScrollView) {
        let collectionOrigin = collectionViewCouch!.bounds.origin
        let collectionWidth = collectionViewCouch!.bounds.width
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
        
        let index = collectionViewCouch!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewCouch.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewCouch.indexPathForCell(cell!)?.item
                self.couch = stringArray[selectedCell!]
            }
        }
    }
    
    
    
//****************************************************************************************************
//------------------------  Matress: getting central value of collection view ------------------------
    
    func findCenterIndexMatress(scrollView: UIScrollView) {
        let collectionOrigin = collectionViewMatress!.bounds.origin
        let collectionWidth = collectionViewMatress!.bounds.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        let index = collectionViewMatress!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewMatress.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewMatress.indexPathForCell(cell!)?.item
                self.matress = stringArray[selectedCell!]
            }
        }
    }
    
    

//****************************************************************************************************
//----------------------  Air Matress: getting central value of collection view ----------------------
    func findCenterIndexAirMatress(scrollView: UIScrollView) {
        let collectionOrigin = collectionViewAirMatress!.bounds.origin
        let collectionWidth = collectionViewAirMatress!.bounds.width
        var centerPoint: CGPoint!
        var newX: CGFloat!
        if collectionOrigin.x == collectionWidth / 2 {
            newX = collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        } else {
            newX = collectionOrigin.x + collectionWidth / 2
            centerPoint = CGPoint(x: newX, y: collectionOrigin.y)
        }
        
        let index = collectionViewAirMatress!.indexPathForItemAtPoint(centerPoint)
        
        if(index != nil){
            let cell =
                collectionViewAirMatress.cellForItemAtIndexPath(index!) as? collectionViewCell
            if(cell != nil){
                selectedCell = collectionViewAirMatress.indexPathForCell(cell!)?.item
                self.airMatress = stringArray[selectedCell!]
            }
        }
    }
    
    
    
//****************************************************************************************************
//-----------------------------------  SEND DATA TO DATABASE -----------------------------------------
    @IBAction func nextBtn_clicked(sender: AnyObject) {
        
        //the dafault value to send in database
        if twinBed.isEmpty && singleBed.isEmpty && couch.isEmpty && matress.isEmpty && airMatress.isEmpty {
            // if user touch at least one collection view, the celle values are recognized otherwise set them to 0:
            twinBed = "0"
            singleBed = "0"
            couch = "0"
            matress = "0"
            airMatress = "0"
        }
    
        // if all variables sending data are zero: user doesn't choose a place to sleep
        if twinBed == "0" && singleBed == "0" && couch == "0" && matress == "0" && airMatress == "0" {
        
            //alert
            let alert = UIAlertController(title: "Missing data", message: "Please, choose at least one sleeping place", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {

            //send data
            listing.twinBed = twinBed
            listing.singleBed = singleBed
            listing.couch = couch
            listing.mattress = matress
            listing.airMattress = airMatress
            
            // going to next controller: listingAmenitiesVC
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingAmenitiesVC") as? listingAmenitiesVC
            self.navigationController?.pushViewController(next!, animated: true)
            
        }
    }
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back: listingInfo2VC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo1VC") as! listingInfo1VC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}






