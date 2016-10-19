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
    
    var photoArray = [UIImage]()
    var mainPhotoDB = UIImage()
    
    var width = CGFloat()
    var height = CGFloat()
    var cellWidth = CGFloat()
    
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ***********************************************
    
    @IBOutlet var mainPhotoLbl: UILabel!
    @IBOutlet var mainPhoto: UIImageView!
    @IBOutlet var addPhotoBtn: UIButton!
    
    // collection view for listing photos
    @IBOutlet var collectionView: UICollectionView!
    
    // to go to next controller
    @IBOutlet var nextBtn: UIButton!
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        collectionView?.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//***************************************** CELLS CONFIGURATION ***********************************
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return listing.photos.count + photoArray.count
        
    }

    // cell's items
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // defining cells
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("listingPhoto", forIndexPath: indexPath) as! listingPhotoCell
        
        if listing.photos.count == 0 {
            if let imageView = cell.viewWithTag(1000) as? UIImageView {
                imageView.image = photoArray[indexPath.row]
                
                
                /* all UIView subclasses have a method called viewWithTag(), which searches for any views inside itself (or indeed itself) with that tag number */
            }
            
        }
        else {
            cell.listingPhotoImg.image = listing.photos[indexPath.row]
            if let imageView = cell.viewWithTag(1000) as? UIImageView {
                imageView.image = photoArray[indexPath.row]
                
                
                /* all UIView subclasses have a method called viewWithTag(), which searches for any views inside itself (or indeed itself) with that tag number */
            }

            
        }
        
        
        //image frame size
        cell.listingPhotoImg.frame.size = CGSize(width: cellWidth, height: cellWidth)
        
        // remove photo
        cell.removePhotoBtn?.layer.setValue(indexPath.row, forKey: "index")
        cell.removePhotoBtn?.addTarget(self, action: #selector(listingPhotosVC.removePhoto(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    
    // items' size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let dim = CGSize(width: cellWidth, height: cellWidth)
        return dim
    }
    
    
    // select a cell: display main phto + animation
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let cell = collectionView.cellForItemAtIndexPath(indexPath)! as! listingPhotoCell
        
        // display the main phtoto of listing
        self.mainPhoto.image = cell.listingPhotoImg.image
        self.mainPhotoDB = cell.listingPhotoImg.image!
        
        // cell animation on taping
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [],
            animations: {
                cell.transform = CGAffineTransformMakeScale(0.9, 0.9)
                                    
            },
            completion: { finished in UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .CurveEaseInOut, animations: {
                    cell.transform = CGAffineTransformMakeScale(1, 1)
                },
                completion: nil
                )
            }
        )
    }
    
    
    // remove a photo from a cell
    func removePhoto (sender:UIButton) {
        let i : Int = (sender.layer.valueForKey("index")) as! Int
        photoArray.removeAtIndex(i)
        mainPhoto.image = photoArray.first
        collectionView.reloadData()
        
        if photoArray.isEmpty {
            self.mainPhotoLbl.hidden = false
        }
        else {
            self.mainPhotoLbl.hidden = true
        }
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
        if photoArray.count <= 8 {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .PhotoLibrary
            presentViewController(picker, animated: true, completion: nil)
        }
        else {
            alert("Maximum 9 photos", message: "Sorry, you can not post more thant 9 photos")
        }
        print(photoArray.count)
    }
    
    
    // function to finilize UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        photoArray.insert(image, atIndex: 0)
        mainPhoto.image = photoArray.first
        collectionView?.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    
        // hidie the main photo message
        self.mainPhotoLbl.hidden = true
        
    }
    

    
//-------------------------------------------------------------------------------------------------
//*********************************** GOING TO THE NEXT CONTROLLER ********************************
    @IBAction func nextBtn_clicked(sender: AnyObject) {
        
        //clean array to don not append twice when comming back from next VC and then going to it
        listing.photos.removeAll()
        
        if self.photoArray.contains(self.mainPhotoDB) {
            
            // appending the main photo of listing at first row of listing.photos
            let row = self.photoArray.indexOf(self.mainPhotoDB)
            self.photoArray.removeAtIndex(row!)
            listing.photos.append(self.mainPhotoDB)
            
            for photo in self.photoArray {
                listing.photos.append(photo)
            }
        }
        else {
            for photo in photoArray{
                listing.photos.append(photo)
            }
        }
        
        print(" ")
        print("Picked photos:", photoArray)
        photoArray.removeAll()
        print("")
        print(mainPhoto)
        print("listingClass saved photos:", listing.photos)
    
        // going to next controller: listingInfo3VC
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingInfo3VC") as! listingInfo3VC
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
}



//-------------------------------------------------------------------------------------------------
//***************************************** CELL CLASS ********************************************

class listingPhotoCell: UICollectionViewCell {
    
    @IBOutlet var removePhotoBtn: UIButton!
    @IBOutlet var listingPhotoImg: UIImageView!
    
}
