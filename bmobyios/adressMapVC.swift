//
//  adressMapVC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/6/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import MapKit


protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class adressMapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
//----------------------------------------------------------------------------------------------------
//****************************************** Local Variables *****************************************
    
    // class to manage the data from one controller to other
    var createListingAdress = listingClass()
        
    // listing id to update the photos and controller to show the update buttons
    var id = String()
    var controller = String()
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    let locationManager: CLLocationManager = CLLocationManager()
    
    //listing's location
    var currentLocation: CLLocation?
    
    // data send to the database
    var street = String()
    var postalCode = String()
    var city = String()
    var country = String()
    var longitude = String()
    var latitude = String()
    
    var fullAdress = String()
    
    
    
//--------------------------------------------------------------------------------------------------------------
//****************************************** Outlets ***********************************************************
    @IBOutlet weak var adressTitleLbl: UILabel!
    @IBOutlet weak var adressTxt: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var doNotUpdateBtn: UIButton!
    
    
//--------------------------------------------------------------------------------------------------------------
//****************************************** Default function **************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initiating map kit
        self.mapView.delegate = self
        
        //Initiating Core Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        mapView!.showsUserLocation = true
        
        
        
        //Calling the addressSearchTC - table controller
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("adressSearchTVC") as! adressSearchTVC
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        
        //Setting the search bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        //Handle of the mapView from the main View Controller onto the locationSearchTable
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        
        // hide and show buttons dependng on previous controller
        if controller == "myListngVC" {
            nextBtn.hidden = true
            //backBtn.hidden = true
            
            updateBtn.hidden = false
            doNotUpdateBtn.hidden = false
        }
        else {
            nextBtn.hidden = false
            //backBtn.hidden = false
            
            updateBtn.hidden = true
            doNotUpdateBtn.hidden = true
        }
        
    }
    
    
    
//--------------------------------------------------------------------------------------------------------------
//****************************************** Core Location methods *********************************************
    
    //Requesting the user's permission and if permitted getteng user's location
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    
    // Core location manager updating
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
        // longitude and latitude
        latitude = "\(location.coordinate.latitude)"
        longitude = "\(location.coordinate.longitude)"
        
        
        //getting the info from geolocation
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            else {
                let pm = placemarks![0] as CLPlacemark
                self.street = pm.addressDictionary!["Street"] as! String
                self.postalCode = pm.postalCode!
                self.city = pm.locality!
                self.country = pm.country!
                
            }
            
            //attributing the informations to the text view when geolocation finds adress
            self.fullAdress = self.street + ", " + self.postalCode + " " + self.city + ", " + self.country
            self.adressTxt.text = self.fullAdress
            
            //adding title and subtitle to current location
            let currentLocation: MKUserLocation = self.mapView.userLocation
            currentLocation.title = self.street
            currentLocation.subtitle = self.postalCode + " " + self.city + ", " + self.country
            
        })
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
    
    
    
//--------------------------------------------------------------------------------------------------------------
//****************************************** Map Kit Methods ***************************************************
    
    // When location is updated
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        //User curent location
        //self.currentLocation = userLocation.location!
        
        //Zooming the location when controller is launched
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000, 5000)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    
    // Annotation View
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{

        //Custom annotation view
        var annotationView = self.mapView?.dequeueReusableAnnotationViewWithIdentifier("annotationIdentifier")
        annotationView = adressAnnotView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
        annotationView!.canShowCallout = true
        
        
        //hide the current location when searching manually the adress
        if self.mapView.annotations.count > 1 {
            self.mapView.showsUserLocation = false
        }
        
        return annotationView
    }
    
    @IBAction func nextBtn_clicked(sender: AnyObject) {
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("listingTypeVC") as! listingTypeVC
        
        // data to send to database: geolocation/manually. atributing data to the listingClass
        self.createListingAdress.street = street
        self.createListingAdress.postalCode = postalCode
        self.createListingAdress.city = city
        self.createListingAdress.country = country
        self.createListingAdress.latitude = latitude
        self.createListingAdress.longitude = longitude
        next.createListingType = createListingAdress
        
        self.presentViewController(next, animated: true, completion: nil)
    }
    
    
    
//-------------------------------------------------------------------------------------------------
//*********************************** UPDATING THE LISTING ADDRESS ********************************
    
    @IBAction func updateBtn_clicked(sender: AnyObject) {
        
        // data to send to database: geolocation/manually. atributing data to the listingClass
        self.createListingAdress.street = street
        createListingAdress.postalCode = postalCode
        createListingAdress.city = city
        createListingAdress.country = country
        createListingAdress.latitude = latitude
        createListingAdress.longitude = longitude
        
        let query = PFQuery(className: "listing")
        query.getObjectInBackgroundWithId(self.id) {(object: PFObject?, error: NSError?) in
            
            if error == nil {
                let fullAddress = self.street+", "+self.postalCode+" "+self.city+", "+self.country
                
                object?.setValue(self.createListingAdress.street, forKey: "street")
                object?.setValue(self.createListingAdress.postalCode, forKey: "postalCode")
                object?.setValue(self.createListingAdress.city, forKey: "city")
                object?.setValue(self.createListingAdress.country, forKey: "country")
                object?.setValue(self.createListingAdress.latitude, forKey: "latitude")
                object?.setValue(self.createListingAdress.longitude, forKey: "longitude")
                object?.setValue(fullAddress, forKey: "fullAdress")
                
                object?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                    if error == nil {
                        let storyBoard = UIStoryboard(name: "backoffice", bundle: nil)
                        let back = storyBoard.instantiateViewControllerWithIdentifier("myListingVC") as! myListingVC
                        back.id = self.id
                        self.presentViewController(back, animated: true, completion: nil)
            
                        print("adress has been successfully updated")
                        
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
        print("let me go back")
    }
    
}



//-------------------------------------------------------------------------------------------
//********************************* Handle Map Search ***************************************

extension adressMapVC: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.addressDictionary!["Street"] as? String
        
        if let postalCode = placemark.postalCode, let city = placemark.locality,
            let country = placemark.country {
            
            // displaying the subtitle: postal code, city and country
            annotation.subtitle = "\(postalCode) \(city), \(country)"
            
            
            //Displaying the full listing's adress
            if adressTxt.text != nil {
                self.street = (placemark.addressDictionary!["Street"] as! String)
                self.postalCode = postalCode
                self.city = city
                self.country = country
                
                //attributing the informations to the text view when manually adress found
                self.fullAdress = self.street+", "+self.postalCode+" "+self.city+", "+self.country
                self.adressTxt.text = self.fullAdress
                
                // longitude and latitude
                latitude = "\(placemark.location?.coordinate.latitude)"
                longitude = "\(placemark.location?.coordinate.longitude)"
            }            
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

