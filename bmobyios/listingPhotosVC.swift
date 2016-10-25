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
    
    var controller = String()
    
    var width = CGFloat()
    var height = CGFloat()
    var cellWidth = CGFloat()
    
    
    
    
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
        
        self.navigationController?.navigationBar.hidden = true
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
            //nextBtn.userInteractionEnabled = false
            backBtn.hidden = true
            //backBtn.userInteractionEnabled = false
            
            updateBtn.hidden = false
            //updateBtn.userInteractionEnabled = true
            doNotUpdateBtn.hidden = false
            //doNotUpdateBtn.userInteractionEnabled = true
            print(controller)
        }
        else {
            nextBtn.hidden = false
            nextBtn.userInteractionEnabled = true
            backBtn.hidden = false
            backBtn.userInteractionEnabled = true
            
            updateBtn.hidden = true
            updateBtn.userInteractionEnabled = false
            doNotUpdateBtn.hidden = true
            updateBtn.userInteractionEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.navigationController?.pushViewController(next, animated: true)
        next.createListingFinal = createListingPhotos
        
    }
    
    
    @IBAction func backBtn_clicked(sender: AnyObject) {
        // going back: listingAmenitiesVC
        let back = self.storyboard?.instantiateViewControllerWithIdentifier("listingAmenitiesVC") as! listingAmenitiesVC
        self.navigationController?.pushViewController(back, animated: true)
        back.createListingAmenities = createListingPhotos

    }
    
    
    @IBAction func updateBtn_clicked(sender: AnyObject) {
        print(self.createListingPhotos.photos)
        print("update")
    }
    
    @IBAction func doNotUpdateBtn_clicked(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
        self.navigationController?.pushViewController(back, animated: true)
        print("do not update")
    }
    
    
    
}



//-------------------------------------------------------------------------------------------------
//***************************************** CELL CLASS ********************************************

class listingPhotoCell: UICollectionViewCell {
    
    @IBOutlet var removePhotoBtn: UIButton!
    @IBOutlet var listingPhotoImg: UIImageView!
    
}


