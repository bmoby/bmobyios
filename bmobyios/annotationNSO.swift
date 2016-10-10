//
//  annotationNO.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/6/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class annotationNSO: NSObject {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
