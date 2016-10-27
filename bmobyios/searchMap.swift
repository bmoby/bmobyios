//
//  searchMap.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 26/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit



class searchMap: UIViewController, SendListingsArrayToSearchController, CLLocationManagerDelegate{

    var listingsArray = [listingClass]()
    var selectedCity: String?
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LOCATION MANAGER
        //--------------------
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // ------------------------------------------------------------------------
        //-------------------------------------------------------------------------
        
    }
    
    
    
    
    // Protocol listener to get the listings array
    func listingsFound(data: [listingClass]) {
        if data.count == 0 {
            print("there is no data sorry!")
        } else {
            self.listingsArray = data
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        
        
        if self.currentLocation.latitude == locValue.latitude && self.currentLocation.longitude == locValue.longitude{
            return
        } else {
            
            // SETTING THE MAP WITH CURRENT LOCATION AND A CIRCLE
            self.currentLocation = locValue
            let camera = GMSCameraPosition(target: locValue, zoom: 14, bearing: 0, viewingAngle: 50)
            let listingMap = GMSMapView()
            listingMap.myLocationEnabled = true
            listingMap.frame = self.view.frame
            listingMap.camera = camera
            let circle = GMSCircle(position: self.currentLocation, radius: 300)
            circle.map = listingMap
            
            
            // SETTING THE LISTINGS
            for listing in self.listingsArray {
                
                let latitude = Double(listing.latitude)
                let longitude = Double(listing.longitude)
                let position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                
                let marker = GMSMarker(position: position)
                marker.title = listing.price
                
                if GMSGeometryDistance(position, self.currentLocation) < 300 {
                    marker.map = listingMap
                } else {
                    print("Too far from you!")
                }
            }
            
            self.view.addSubview(listingMap)
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
