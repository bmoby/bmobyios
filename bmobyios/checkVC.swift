//
//  checkVC.swift
//  bmobyios
//
//  Created by Magomed Souleymnov on 23/10/2016.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

// Declaring protocol who will serve as data transfer function to homePageVC
protocol SendSelectedCityToHome {
    
    func userDidSelectACity(data: String)
}

class checkVC: UICollectionViewController, UISearchBarDelegate, UISearchControllerDelegate, PassDataToCheckVC {
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* SEGUES AND VARS ************************************
    
    
    
    var delegate:SendSelectedCityToHome? = nil
    var cities = [city]()
    var selectedCity : String?
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var tapedCity:String?
    
    // Action that launches the search bar
    @IBAction func searchBtnClicked(sender: AnyObject) {
        
        searchResultController.delegate = self
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.presentViewController(searchController, animated: true, completion: nil)
    }

    
    
    // -----------------------------------------------------------------------------------
    //******************************* DELEGATE METHOD ************************************
    
    
    // Method thats allaus us to send info to homePage with delegate method
    func selectedCityInSearchBar(data: String) {
        
        self.tapedCity = data
        if self.tapedCity != nil {
            
            if self.delegate != nil {
                
                let data = self.tapedCity
                delegate?.userDidSelectACity(data!)
                self.tabBarController?.selectedIndex = 0
            }
            
        } else {
            
            print("checkVC: self.tapedCity is nil, sleedCityInSearchBar function can not be executed!")
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************* DEFAULT METHODS ************************************
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        createCities()
        self.collectionView?.reloadData()
        print(self.selectedCity)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        
        // Settings to make autocomplete functional
        searchResultController = SearchResultsController()
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //***************************** AUTOCOMPLETE METHOD **********************************
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error: NSError?) -> Void in
            
            self.resultsArray.removeAll()
            if results == nil {
                
                print(error!.localizedDescription)
            } else {
                
                for result in results! {
                    
                    self.resultsArray.append(result.attributedFullText.string)
                }
                self.searchResultController.reloadDataWithArray(self.resultsArray)
            }
            return
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //****************************** COLLECTION METHODS **********************************
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.cities.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("citiesCell", forIndexPath: indexPath) as! cityCell
            cell.icon.image = self.cities[indexPath.row].icon
            cell.name.text = self.cities[indexPath.row].name
        
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! cityCell
        cell.name.textColor = UIColor.darkGrayColor()
        
        if self.delegate != nil {
            
            let data = self.cities[indexPath.row].description
            delegate?.userDidSelectACity(data!)
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------
    //******************************** HELPER METHODS ************************************
    
    
    
    func createCities() {
        
        let city01 = city()
        city01.icon = UIImage(named: "london")
        city01.name = "London"
        city01.description = "London, United Kingdom"
        
        let city02 = city()
        city02.icon = UIImage(named: "newYork")
        city02.name = "New York"
        city02.description = "New York, NY, United States"
        
        let city03 = city()
        city03.icon = UIImage(named: "paris")
        city03.name = "Paris"
        city03.description = "Paris, France"
        
        let city04 = city()
        city04.icon = UIImage(named: "sanFrancisco")
        city04.name = "San Francisco"
        city04.description = "San Francisco, CA, United States"
        
        let city05 = city()
        city05.icon = UIImage(named: "tokyo")
        city05.name = "Tokyo"
        city05.description = "Tokio, Japan"
        
        let city06 = city()
        city06.icon = UIImage(named: "berlin")
        city06.name = "Berlin"
        city06.description = "Berlin, Germany"
        
        let city07 = city()
        city07.icon = UIImage(named: "barcelona")
        city07.name = "Barcelona"
        city07.description = "Barcelona, Spain"
        
        let city08 = city()
        city08.icon = UIImage(named: "amsterdam")
        city08.name = "Amsterdam"
        city08.description = "Amsterdam, Netherlands"
        
        self.cities.append(city01)
        self.cities.append(city02)
        self.cities.append(city03)
        self.cities.append(city04)
        self.cities.append(city05)
        self.cities.append(city06)
        self.cities.append(city07)
        self.cities.append(city08)
    }
}
