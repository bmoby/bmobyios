//
//  myListingVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/21/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

class myListingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//--------------------------------------------------------------------------------------------------
//***************************************** LOCAL VARIABLES ****************************************
    
    var id = String()
    var price = String()
    var prices = [String]()
    var checkin = String()
    
    //photo
    var mainPhoto = [PFFile]()
    var listingPhotos = [PFFile]()
    
    var fullAdress = String()
    var listingType = String()
    var propertyType = String()
    
    //general info
    var rooms = String()
    var hostingCapacity = String()
    var kitchens = String()
    var bathrooms = String()
    var genInfo = [String]()
    var genInfoIcon = [UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon")]
    
    // sleep info
    var twinBed = String()
    var singleBed = String()
    var couch = String()
    var mattress = String()
    var airMattress = String()
    var sleep = [String]()
    var sleepIcon = [UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon"), UIImage(named: "adressIcon")]
    
    // amenities array to hold the names (string)
    var amenities = [String]()
    // array that will be completed by icons
    var amenitiesIcon = [UIImage]()
    // giving names to the amenities to pick up icons (key: value)
    var amenIconNames = ["breakfast": UIImage(named: "breakfast"), "wifi/internet": UIImage(named: "wifi"), "wheelchairaccessible": UIImage(named: "wheelchairaccessible"), "tv": UIImage(named: "tv"), "lock for bedroom": UIImage(named: "lock for bedroom"), "dryer": UIImage(named: "dryer"), "iron": UIImage(named: "iron"), "washer": UIImage(named: "washer"), "hair dryer": UIImage(named: "hair dryer"), "smoking allowed": UIImage(named: "smoking allowed"), "intercom": UIImage(named: "intercom"), "air conditioner": UIImage(named: "air conditioner"), "family/kids": UIImage(named: "family"), "pets allowed": UIImage(named: "pets allowed"), "parking": UIImage(named: "parking"), "indoor fireplace": UIImage(named: "indoor fireplace"), "gym": UIImage(named: "gym"), "pool": UIImage(named: "pool"), "sauna": UIImage(named: "sauna"), "hammam": UIImage(named: "hammam"), "jacuzzi": UIImage(named: "jacuzzi"), "elevator": UIImage(named: "elevator")]
    
    
    
//--------------------------------------------------------------------------------------------------
//***************************************** OUTLETS ************************************************
    
    //scroll view
    @IBOutlet var scrollView: UIScrollView!
    
    //ava
    @IBOutlet var avaImg: UIImageView!
    
    // title data
    @IBOutlet var gradeLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var checkinLbl: UILabel!
    
    //listing photos
    @IBOutlet var photosCollectionView: UICollectionView!
    
    //address
    @IBOutlet var addressTxt: UITextView!
    
    // listing type
    @IBOutlet var listingTypeView: UIView!
    @IBOutlet var listingTypeImg: UIImageView!
    @IBOutlet var listingTypeLbl: UILabel!
    
    //property type
    @IBOutlet var propertyTypeView: UIView!
    @IBOutlet var propertyTypeImg: UIImageView!
    @IBOutlet var propertyTypeLbl: UILabel!
    
    // generalInfo: number of rooms, hosting capacity.. 
    @IBOutlet var genInfoCollectionView: UICollectionView!
    
    // place to sleep collecton view
    @IBOutlet var sleepCollectionView: UICollectionView!
    
    // amenities collection view
    @IBOutlet var amenitiesCollectionView: UICollectionView!
    
    //  edit buttons
    @IBOutlet var editListingPhotoBtn: UIButton!
    @IBOutlet var editAddressBtn: UIButton!
    @IBOutlet var editListingPropertyTypeBtn: UIButton!
    @IBOutlet var editGenInfoBtn: UIButton!
    @IBOutlet var editSleepBtn: UIButton!
    @IBOutlet var editAmenitiesBtn: UIButton!
    
    // deactivate temporarily and delete listing buttons
    @IBOutlet var deactivateTemporarilyBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    
    
    
//--------------------------------------------------------------------------------------------------
//***************************************** DEFAULT ************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view width and height
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        // scrollview
        self.scrollView.frame.origin = CGPoint(x: 0, y: 0)
        self.scrollView.contentSize = CGSize(width: width, height: height + 260)
        
        // collection view delegate
        self.photosCollectionView.delegate = self
        self.genInfoCollectionView.delegate = self
        self.sleepCollectionView.delegate = self
        self.amenitiesCollectionView.delegate = self
        
        // collection view source
        self.photosCollectionView.dataSource = self
        self.genInfoCollectionView.dataSource = self
        self.sleepCollectionView.dataSource = self
        self.amenitiesCollectionView.dataSource = self
        
        // query to load data
        loadMyListing()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//---------------------------------------------------------------------------------------------------
//***************************************** QUERY TO LOAD DATA **************************************
    func loadMyListing() {
        let query = PFQuery(className: "listing")
        query.whereKey("uuid", equalTo: "1")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                
                self.listingPhotos.removeAll(keepCapacity: false)
                self.genInfo.removeAll(keepCapacity: false)
                self.sleep.removeAll(keepCapacity: false)
                self.amenities.removeAll(keepCapacity: false)
                self.amenitiesIcon.removeAll(keepCapacity: false)
                
                for object in objects! {
                    if object.objectId == self.id {
                        self.priceLbl.text! = "\(object.objectForKey("price") as! String) euros"
                        self.checkinLbl.text! = "checkin time: \(object.valueForKey("checkin") as! String)"
                        
                        // photos
                        self.mainPhoto.append(object.valueForKey("mainPhoto") as! PFFile)
                        
                        if object.valueForKey("listingPhoto1") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto1") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto2") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto2") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto3") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto3") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto4") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto4") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto5") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto5") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto6") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto6") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto7") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto7") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto8") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto8") as! PFFile)
                        }
                        if object.valueForKey("listingPhoto9") != nil {
                            self.listingPhotos.append(object.valueForKey("listingPhoto9") as! PFFile)
                        }
                        
                        self.addressTxt.text! = object.valueForKey("fullAdress") as! String
                        self.listingTypeLbl.text! = object.valueForKey("listingType") as! String
                        self.propertyTypeLbl.text! = object.valueForKey("propertyType") as! String
                        
                        // general info
                        self.genInfo.append(object.valueForKey("rooms") as! String)
                        self.genInfo.append(object.valueForKey("hostingCapacity") as! String)
                        self.genInfo.append(object.valueForKey("kitchens") as! String)
                        self.genInfo.append(object.valueForKey("bathrooms") as! String)
                        
                        // sleep info
                        self.sleep.append(object.valueForKey("twinBed") as! String)
                        self.sleep.append(object.valueForKey("singleBed") as! String)
                        self.sleep.append(object.valueForKey("couch") as! String)
                        self.sleep.append(object.valueForKey("mattress") as! String)
                        self.sleep.append(object.valueForKey("airMattress") as! String)
                        
                        // amenities 
                        if object.valueForKey("amenity0") != nil {
                            self.amenities.append(object.valueForKey("amenity0") as! String)
                            let amenityName = (object.valueForKey("amenity0") as! String)
                            // matching the icon name and amenity value from data base, and then appending to display
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity1") != nil {
                            self.amenities.append(object.valueForKey("amenity1") as! String)
                            let amenityName = (object.valueForKey("amenity1") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity2") != nil {
                            self.amenities.append(object.valueForKey("amenity2") as! String)
                            let amenityName = (object.valueForKey("amenity2") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity3") != nil {
                            self.amenities.append(object.valueForKey("amenity3") as! String)
                            let amenityName = (object.valueForKey("amenity3") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity4") != nil {
                            self.amenities.append(object.valueForKey("amenity4") as! String)
                            let amenityName = (object.valueForKey("amenity4") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity5") != nil {
                            self.amenities.append(object.valueForKey("amenity5") as! String)
                            let amenityName = (object.valueForKey("amenity5") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity6") != nil {
                            self.amenities.append(object.valueForKey("amenity6") as! String)
                            let amenityName = (object.valueForKey("amenity6") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity7") != nil {
                            self.amenities.append(object.valueForKey("amenity7") as! String)
                            let amenityName = (object.valueForKey("amenity7") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity8") != nil {
                            self.amenities.append(object.valueForKey("amenity8") as! String)
                            let amenityName = (object.valueForKey("amenity8") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity9") != nil {
                            self.amenities.append(object.valueForKey("amenity9") as! String)
                            let amenityName = (object.valueForKey("amenity9") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity10") != nil {
                            self.amenities.append(object.valueForKey("amenity10") as! String)
                            let amenityName = (object.valueForKey("amenity10") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity11") != nil {
                            self.amenities.append(object.valueForKey("amenity11") as! String)
                            let amenityName = (object.valueForKey("amenity11") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity12") != nil {
                            self.amenities.append(object.valueForKey("amenity12") as! String)
                            let amenityName = (object.valueForKey("amenity12") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity13") != nil {
                            self.amenities.append(object.valueForKey("amenity13") as! String)
                            let amenityName = (object.valueForKey("amenity13") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity14") != nil {
                            self.amenities.append(object.valueForKey("amenity14") as! String)
                            let amenityName = (object.valueForKey("amenity14") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity15") != nil {
                            self.amenities.append(object.valueForKey("amenity15") as! String)
                            let amenityName = (object.valueForKey("amenity15") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity16") != nil {
                            self.amenities.append(object.valueForKey("amenity16") as! String)
                            let amenityName = (object.valueForKey("amenity16") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity17") != nil {
                            self.amenities.append(object.valueForKey("amenity17") as! String)
                            let amenityName = (object.valueForKey("amenity17") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity18") != nil {
                            self.amenities.append(object.valueForKey("amenity18") as! String)
                            let amenityName = (object.valueForKey("amenity18") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity19") != nil {
                            self.amenities.append(object.valueForKey("amenity19") as! String)
                            let amenityName = (object.valueForKey("amenity19") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity20") != nil {
                            self.amenities.append(object.valueForKey("amenity20") as! String)
                            let amenityName = (object.valueForKey("amenity20") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        if object.valueForKey("amenity21") != nil {
                            self.amenities.append(object.valueForKey("amenity21") as! String)
                            let amenityName = (object.valueForKey("amenity21") as! String)
                            for (name, icon) in self.amenIconNames {
                                if amenityName == name {
                                    self.amenitiesIcon.append(icon!)
                                }
                            }
                        }
                        
                        self.photosCollectionView.reloadData()
                        self.genInfoCollectionView.reloadData()
                        self.sleepCollectionView.reloadData()
                        self.amenitiesCollectionView.reloadData()
                    }
                }
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
//---------------------------------------------------------------------------------------------------
//***************************************** COLLECTION VIEW *****************************************
    
    // number of items in section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.photosCollectionView {
            return listingPhotos.count
        }
        else if collectionView == self.genInfoCollectionView {
            return genInfo.count
        }
        else if collectionView == self.sleepCollectionView {
            return sleep.count
        }
        else {
            return amenitiesIcon.count
        }
    }
    
    
    // collection views data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.photosCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myListingPhotoCell", forIndexPath: indexPath) as! myListingPhotoCell
            self.listingPhotos[indexPath.row].getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
                if error == nil {
                    cell.listingPhotoImg.image = UIImage(data: data!)
                }
            }
            return cell
        }
        else if collectionView == self.genInfoCollectionView {
            let cell2 = collectionView.dequeueReusableCellWithReuseIdentifier("genInfoCell", forIndexPath: indexPath) as! genInfoCell
            cell2.genLbl.text = genInfo[indexPath.row]
            cell2.genImg.image = genInfoIcon[indexPath.row]
            
            return cell2
        }
        else if collectionView == self.sleepCollectionView {
            let cell3 = collectionView.dequeueReusableCellWithReuseIdentifier("sleepCell", forIndexPath: indexPath) as! sleepCell
            cell3.sleepLbl.text = sleep[indexPath.row]
            cell3.sleepImg.image = sleepIcon[indexPath.row]
            
            return cell3
        }
        else {
            let cell4 = collectionView.dequeueReusableCellWithReuseIdentifier("amenitiesCell", forIndexPath: indexPath) as! amenitiesCell
            cell4.amenitiesImg.image = amenitiesIcon[indexPath.row]
            
            return cell4
        }
    }
    
    
    // go to the full screen photo displaying controller
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("fullScreenPhotosVC") as! fullScreenPhotosVC
        next.listingPhotos = listingPhotos
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    
//---------------------------------------------------------------------------------------------------
//***************************************** ACTION BUTTONS ******************************************

    
    @IBAction func editListingPhotoBtn_clicked(sender: AnyObject) {
        
        let storyBoard = UIStoryboard(name: "createListing", bundle: nil)
        let next = storyBoard.instantiateViewControllerWithIdentifier("listingPhotosVC") as! listingPhotosVC
        self.navigationController?.pushViewController(next, animated: true)
        next.controller = "myListngVC"
        self.mainPhoto[0].getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
            next.mainPhoto?.image = UIImage(data: data!)
        }
        for object in self.listingPhotos {
            object.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) in
                next.createListingPhotos.photos.append(UIImage(data: data!)!)
            })
        }
        
    }
    
    
    @IBAction func editAddressBtn_clicked(sender: AnyObject) {
    }
    
    @IBAction func aditListingPropertyTypeBtn_clicked(sender: AnyObject) {
    }
    
    @IBAction func editGenInfoBtn_clicked(sender: AnyObject) {
    }
    
    @IBAction func editSleepBtn_clicked(sender: AnyObject) {
    }
    
    @IBAction func editAmenitiesBtn_clicked(sender: AnyObject) {
    }

    @IBAction func deactivateTemporarilyBtn_clicked(sender: AnyObject) {
    }
    
    @IBAction func deleteBtn_clicked(sender: AnyObject) {
    }
    
}


//-------------------------------------------------------------------------------------------------
//***************************************** CELL CLASS ********************************************

class myListingPhotoCell: UICollectionViewCell {
    @IBOutlet var listingPhotoImg: UIImageView!
    
}

class genInfoCell: UICollectionViewCell {
    @IBOutlet var genImg: UIImageView!
    @IBOutlet var genLbl: UILabel!
    
}

class sleepCell: UICollectionViewCell {
    @IBOutlet var sleepImg: UIImageView!
    @IBOutlet var sleepLbl: UILabel!
    
}

class amenitiesCell: UICollectionViewCell {
    @IBOutlet var amenitiesImg: UIImageView!
    
}















