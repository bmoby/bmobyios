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
    
//--------------------------------------------------------------------------------------------------------------
//****************************************** Local Variables ***************************************************
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    let locationManager: CLLocationManager = CLLocationManager()
    
    //listing's location
    var currentLocation: CLLocation?
    var street = String()
    var postalCode = String()
    var city = String()
    var country = String()
    var fullAdress = String()
    var longitude = String()
    var latitude = String()
    
    
    
//--------------------------------------------------------------------------------------------------------------
//****************************************** Outlets ***********************************************************
    @IBOutlet weak var adressTitleLbl: UILabel!
    @IBOutlet weak var adressTxt: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
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
        print(latitude, longitude)
        
        
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
            print(self.street, self.city, self.postalCode, self.country)
            
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
    
}



//--------------------------------------------------------------------------------------------------------------
//****************************************** Handle Map Search *************************************************

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
                self.fullAdress = self.street + ", " + self.postalCode + " " + self.city + ", " + self.country
                self.adressTxt.text = self.fullAdress
                print(self.street, self.city, self.postalCode, self.country)
                
                // longitude and latitude
                latitude = "\(placemark.location?.coordinate.latitude)"
                longitude = "\(placemark.location?.coordinate.longitude)"
                print(latitude, longitude)
            }
            
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

