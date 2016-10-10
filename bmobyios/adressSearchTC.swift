//
//  adressSearchTC.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/6/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import MapKit

class adressSearchTC: UITableViewController {
    
    
    weak var handleMapSearchDelegate: HandleMapSearch?
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?
    
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        //comma between street number/name and postal code/city
        let firstCommma = (selectedItem.addressDictionary!["Street"] != nil) && (selectedItem.postalCode != nil || selectedItem.locality != nil) ? ", " : ""
        
        // put a space between postal code and city
        let space = (selectedItem.postalCode != nil &&
            selectedItem.locality != nil) ? " " : ""
        
        // put a comma between postalCode/city and country
        let secondComma = (selectedItem.postalCode != nil || selectedItem.locality != nil) &&
            (selectedItem.country != nil) ? ", " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number and name
            selectedItem.addressDictionary!["Street"] as? String ?? "",
            firstCommma,
            //postal code
            selectedItem.postalCode ?? "",
            space,
            // city
            selectedItem.locality ?? "",
            secondComma,
            // country
            selectedItem.country ?? ""
        )
        
        return addressLine
    }
    
}

extension adressSearchTC : UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        
    }
    
}

extension adressSearchTC {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem)
        return cell
    }
    
}

extension adressSearchTC {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(selectedItem)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
