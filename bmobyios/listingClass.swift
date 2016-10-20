//
//  listingClass.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/18/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import Foundation
import Parse

class listingClass {
    //adress
    var street: String = ""
    var postalCode: String = ""
    var city: String = ""
    var country: String = ""
    var latitude: String = ""
    var longitude: String = ""
    
    //type
    var listingType: String = ""
    var propertyType: String = ""
    
    //listing info 1
    var rooms: String = ""
    var hostingCapacity: String = ""
    var kitchens: String = ""
    var bathrooms: String = ""
    
    //listing info 2
    var twinBed: String = ""
    var singleBed: String = ""
    var couch: String = ""
    var mattress: String = ""
    var airMattress: String = ""
    
    //amenities
    var amenities = [String]()
    
    //listing photos
    var photos = [UIImage]()
    var mainPhoto = UIImage(named: "adressIcon")
    var photoPFFile = [PFFile]()
    /*
    var photo1 : UIImage!
    var photo2 : UIImage!
    var photo3 : UIImage!
    var photo4 : UIImage!
    var photo5 : UIImage!
    var photo6 : UIImage!
    var photo7 : UIImage!
    var photo8 : UIImage!
    var photo9 : UIImage!
    */
    
    //listing info 3
    var price: String = ""
    var checkin: String = ""
    var daysORmonths: String = ""
    var hostingPeriod: String = ""
    
    
    func save() {
        let object = PFObject(className: "listing")
        
        //adress
        object["street"] = listing.street
        object["postalCode"] = listing.postalCode
        object["city"] = listing.city
        object["country"] = listing.country
        object["latitude"] = listing.latitude
        object["longitude"] = listing.longitude
            
        // type
        object["listingType"] = listing.listingType
        object["propertyType"] = listing.propertyType
        
        //listing info 1
        object["rooms"] = listing.rooms
        object["hostingCapacity"] = listing.hostingCapacity
        object["kitchens"] = listing.kitchens
        object["bathrooms"] = listing.bathrooms
        
        //listing info 2
        object["twinBed"] = listing.twinBed
        object["singleBed"] = listing.singleBed
        object["couch"] = listing.couch
        object["mattress"] = listing.mattress
        object["airMattress"] = listing.airMattress
        
        //amenities
        if amenities.count > 0 {
            object["amenity0"] = self.amenities[0]
        }
        if amenities.count > 1 {
            object["amenity1"] = self.amenities[1]
        }
        if amenities.count > 2 {
            object["amenity2"] = self.amenities[2]
        }
        if amenities.count > 3 {
            object["amenity3"] = self.amenities[3]
        }
        if amenities.count > 4 {
            object["amenity4"] = self.amenities[4]
        }
        if amenities.count > 5 {
            object["amenity5"] = self.amenities[5]
        }
        if amenities.count > 6 {
            object["amenity6"] = self.amenities[6]
        }
        if amenities.count > 7 {
            object["amenity7"] = self.amenities[7]
        }
        if amenities.count > 8 {
            object["amenity8"] = self.amenities[8]
        }
        if amenities.count > 9 {
            object["amenity9"] = self.amenities[9]
        }
        if amenities.count > 10 {
            object["amenity10"] = self.amenities[10]
        }
        if amenities.count > 11 {
            object["amenity11"] = self.amenities[11]
        }
        if amenities.count > 12 {
            object["amenity12"] = self.amenities[12]
        }
        if amenities.count > 13 {
            object["amenit13"] = self.amenities[13]
        }
        if amenities.count > 14 {
            object["amenity14"] = self.amenities[14]
        }
        if amenities.count > 15 {
            object["amenity15"] = self.amenities[15]
        }
        if amenities.count > 16 {
            object["amenity16"] = self.amenities[16]
        }
        if amenities.count > 17 {
            object["amenity17"] = self.amenities[17]
        }
        if amenities.count > 18 {
            object["amenity18"] = self.amenities[18]
        }
        if amenities.count > 19 {
            object["amenity19"] = self.amenities[19]
        }
        if amenities.count > 20 {
            object["amenity20"] = self.amenities[20]
        }
        if amenities.count > 21 {
            object["amenity21"] = self.amenities[21]
        }
        
        //listing photos
        if self.mainPhoto != UIImage(named: "adressIcon") {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.mainPhoto!, 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "mainPhoto", data: mainPhotoData!)
            object["mainPhoto"] = mainPhotoFile
        }

        
        if self.photos.count > 0 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[0], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listinPhoto1"] = mainPhotoFile
        }
        if self.photos.count > 1 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[1], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto2"] = mainPhotoFile
        }
        if self.photos.count > 2 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[2], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto3"] = mainPhotoFile
        }
        if self.photos.count > 3 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[3], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto4"] = mainPhotoFile
        }
        if self.photos.count > 4 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[4], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto5"] = mainPhotoFile
        }
        if self.photos.count > 5 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[5], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto6"] = mainPhotoFile
        }
        if self.photos.count > 6 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[6], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto7"] = mainPhotoFile
        }
        if self.photos.count > 7 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[7], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto8"] = mainPhotoFile
        }
        if self.photos.count > 8 {
            
            //declaring images data from images UIImageView
            let mainPhotoData = UIImageJPEGRepresentation(self.photos[8], 0.5)
            
            //converting images to PFFile to send to the DB
            let mainPhotoFile = PFFile(name: "default", data: mainPhotoData!)
            object["listingPhoto9"] = mainPhotoFile
        }
        
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success {
                print("listing was saved in DB with success")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
}











