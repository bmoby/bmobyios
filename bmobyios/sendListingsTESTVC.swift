//
//  sendListingsTESTVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 26/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit

protocol SendListingsArrayToSearchController {
    func listingsFound(data: [listingClass])
}

class sendListingsTESTVC: UIViewController {
    
    var listingsArray = [listingClass]()
    var listingDelegate: SendListingsArrayToSearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = self.tabBarController?.viewControllers?[1].childViewControllers.first as! searchMap
        
        self.listingDelegate = controller.self
        
        
        
        let query = PFQuery(className: "listing")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) in
            if error == nil {
                
                for object in objects! {
                    let listingPrototype = listingClass()
                    
                    listingPrototype.price = object.valueForKey("price") as! String
                    listingPrototype.latitude = object.valueForKey("latitude") as! String
                    listingPrototype.longitude = object.valueForKey("longitude") as! String
                    var photosArray = [UIImage]()
                    
                    if object.valueForKey("listinPhoto1") != nil {
                    
                        let photo1File = object.valueForKey("listinPhoto1") as? PFFile
                        photo1File!.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) in
                            if error == nil {
                                let img1 = UIImage(data: data!)
                                photosArray.append(img1!)
                            } else {
                                print(error!.localizedDescription)
                            }
                        })
                    } else {
                        print("there is no photo1")
                    }
                    
                    
                    
                    
                    if object.valueForKey("listinPhoto2") != nil {
                        let photo2File = object.valueForKey("listinPhoto2") as! PFFile
                        photo2File.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) in
                            if error == nil {
                                let img2 = UIImage(data: data!)
                            photosArray.append(img2!)
                            } else {
                            print(error!.localizedDescription)
                            }
                        })
                    } else {
                        print("there is no photo2")
                    }
                
                
                    
                    if object.valueForKey("listinPhoto3") != nil {
                        
                        let photo3File = object.valueForKey("listinPhoto3") as! PFFile
                        photo3File.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) in
                            if error == nil {
                                let img3 = UIImage(data: data!)
                                photosArray.append(img3!)
                            } else {
                                print(error!.localizedDescription)
                            }
                        })
                    } else {
                        print("there is no photo3")
                    }
                    
                    
                    listingPrototype.photos = photosArray
                    listingPrototype.city = object.valueForKey("city") as! String
                    
                    self.listingsArray.append(listingPrototype)
                }
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print(self.listingsArray.first?.price)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var searchBtnClicked: UIButton!

    @IBAction func searchBtnClickedForReal(sender: AnyObject) {
        
            let data = self.listingsArray
            listingDelegate!.listingsFound(data)
        self.tabBarController?.selectedIndex = 1
    }
    
    
}
