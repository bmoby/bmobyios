//
//  listingPhotos.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/16/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class listingPhotosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//--------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    // variable sent from myMistingVC to update the photo data
    
    var createListingPhotos = listingClass()
    
    var width = CGFloat()
    var height = CGFloat()
    var cellWidth = CGFloat()
    
    // listing id to update the photos and controller to show the update buttons
    var id = String()
    var controller = String()
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ***********************************************
    

    @IBOutlet var mainPhoto: UIImageView?
    @IBOutlet var addPhotoBtn: UIButton!
    
    // collection view for listing photos
    @IBOutlet var collectionView: UICollectionView!
    
    // to go to next controller
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var backBtn: UIButton!
    
    // activated buttons when host comes from myLisitngVC
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var doNotUpdateBtn: UIButton!
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
        
        // screen size
        width = self.view.frame.size.width
        height = self.view.frame.size.height
        
        // cell width
        cellWidth = width/3 - 2
        
        // space between cells
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 3
        collectionView!.collectionViewLayout = layout
        
        // collection view delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        if createListingPhotos.mainPhoto != nil {
            self.mainPhoto!.image = createListingPhotos.mainPhoto
        }
        collectionView!.reloadData()
        
        // hide and show buttons dependng on previous controller
        if controller == "myListngVC" {
            nextBtn.hidden = true
            backBtn.hidden = true
            
            updateBtn.hidden = false
            doNotUpdateBtn.hidden = false
        }
        else {
            nextBtn.hidden = false
            backBtn.hidden = false
            
            updateBtn.hidden = true
            doNotUpdateBtn.hidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.collectionView.reloadData()
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** CELLS CONFIGURATION ***********************************
    
    
    // items' size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let dim = CGSize(width: cellWidth, height: cellWidth)
        return dim
    }
    
    
    //
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return createListingPhotos.photos.count     }

    
    // cell's items
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // defining cells
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listingPhoto", forIndexPath: indexPath) as! listingPhotoCell
        
        let image = createListingPhotos.photos[indexPath.row]
        cell.listingPhotoImg.image = image
        
        //image frame size
        cell.listingPhotoImg.frame.size = CGSize(width: cellWidth, height: cellWidth)
        
        // remove photo
        cell.removePhotoBtn?.layer.setValue(indexPath.row, forKey: "index")
        cell.removePhotoBtn?.addTarget(self, action: #selector(listingPhotosVC.removePhoto(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    
    // select a cell: display main phto + animation
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let cell = collectionView.cellForItemAtIndexPath(indexPath)! as! listingPhotoCell
        createListingPhotos.mainPhoto = cell.listingPhotoImg.image
        self.mainPhoto!.image = cell.listingPhotoImg.image
        
        // cell animation on taping
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                cell.transform = CGAffineTransformMakeScale(0.9, 0.9)
                                    
            },
            completion: { finished in UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .CurveEaseInOut, animations:
                {
                cell.transform = CGAffineTransformMakeScale(1, 1)},
                                    completion: nil
            )}
        )
    }
    
    // remove a photo from a cell
    func removePhoto (sender:UIButton) {
        let i : Int = (sender.layer.valueForKey("index")) as! Int
        createListingPhotos.photos.removeAtIndex(i)
        
        
        if createListingPhotos.photos.isEmpty {
            createListingPhotos.mainPhoto = UIImage(named: "adressIcon")
            mainPhoto?.image = createListingPhotos.mainPhoto
        }
        else {
            createListingPhotos.mainPhoto = createListingPhotos.photos.first
            mainPhoto?.image = createListingPhotos.mainPhoto
        }
        collectionView.reloadData()
    }
    

    
//-------------------------------------------------------------------------------------------------
//***************************************** ADD A PHOTO *******************************************
    // alert function
    func alert(error: String, message: String) {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // pick a photo from photo library
    @IBAction func addPhotoBtn_clicked(sender: AnyObject) {
        
        // no more than 9 photos
        if createListingPhotos.photos.count <= 8 {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        }
        else {
            alert("Maximum 9 photos", message: "Sorry, you can not post more thant 9 photos")
        }
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        createListingPhotos.photos.append(image!)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.mainPhoto?.image = createListingPhotos.photos.first
        createListingPhotos.mainPhoto = createListingPhotos.photos.first

        self.collectionView.reloadData()
    }
    

    
//-------------------------------------------------------------------------------------------------
//*********************************** GOING TO THE NEXT CONTROLLER ********************************
    @IBAction func nextBtn_clicked(sender: AnyObject) {
        
        // going to next controller: listingInfo3VC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo3VC") as! listingInfo3VC
        next.createListingFinal = createListingPhotos
        
        self.presentViewController(next, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back: listingAmenitiesVC
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("listingAmenitiesVC") as! listingAmenitiesVC
        back.createListingAmenities = createListingPhotos
        
        self.presentViewController(back, animated: true, completion: nil)

    }
    
    
    
//-------------------------------------------------------------------------------------------------
//*********************************** UPDATING THE LISTING PHOTOS *********************************

    @IBAction func updateBtn_clicked(sender: AnyObject) {
        
        // remove all photos before updating
        removePhotos()
        
        // saving new photos
        let query = PFQuery(className: "listing")
        query.getObjectInBackgroundWithId(id) {(object: PFObject?, error: NSError?) in
            
            if error == nil {
                //listing photos
                if self.createListingPhotos.mainPhoto != nil {

                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.mainPhoto!, 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "mainPhoto", data: mainPhotoData!)
                    object!["mainPhoto"] = mainPhotoFile
                }
                
                if self.createListingPhotos.photos.count > 0 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[0], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto1"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 1 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[1], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto2"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 2 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[2], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto3"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 3 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[3], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto4"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 4 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[4], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto5"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 5 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[5], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto6"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 6 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[6], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto7"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 7 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[7], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto8"] = mainPhotoFile
                }
                if self.createListingPhotos.photos.count > 8 {
                    //declaring images data from images UIImageView
                    let mainPhotoData = UIImageJPEGRepresentation(self.createListingPhotos.photos[8], 0.5)
                    
                    //converting images to PFFile to send to the DB
                    let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
                    object!["listingPhoto9"] = mainPhotoFile
                }
                
                object?.saveInBackgroundWithBlock({ (success: Bool, error:NSError?) in
                    if error == nil {
                        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
                        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
                        back.id = self.id
                        self.presentViewController(back, animated: true, completion: nil)
                        
                        print("photos have been successfully updated")
                        
                    }
                    else {
                        print(error?.localizedDescription)
                    }
                })
            }
                
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    // removing all photos before update
    func removePhotos() {
        let query = PFQuery(className: "listing")
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) in
            
            if error == nil {
                if object?.objectId == self.id {
                    
                    object?.removeObjectForKey("mainPhoto")
                    object?.removeObjectForKey("listingPhoto1")
                    object?.removeObjectForKey("listingPhoto2")
                    object?.removeObjectForKey("listingPhoto3")
                    object?.removeObjectForKey("listingPhoto4")
                    object?.removeObjectForKey("listingPhoto5")
                    object?.removeObjectForKey("listingPhoto6")
                    object?.removeObjectForKey("listingPhoto7")
                    object?.removeObjectForKey("listingPhoto8")
                    object?.removeObjectForKey("listingPhoto9")
                }
                
                object?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                    if error == nil {
                        print("photos have been deleted")
                    }
                    else {
                        print(error?.localizedDescription)
                    }
                })
            }
            else {
                print(error?.localizedDescription)
            }

        }
        
    }
        

    
//-------------------------------------------------------------------------------------------------
//*********************** GOING BACK TO THE myListingVC: no update ********************************
    
    @IBAction func doNotUpdateBtn_clicked(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
        back.id = self.id
        self.presentViewController(back, animated: true, completion: nil)

        print("do not update")
    }
    
}



//-------------------------------------------------------------------------------------------------
//***************************************** CELL CLASS ********************************************

class listingPhotoCell: UICollectionViewCell {
    
    @IBOutlet var removePhotoBtn: UIButton!
    @IBOutlet var listingPhotoImg: UIImageView!
    
}


