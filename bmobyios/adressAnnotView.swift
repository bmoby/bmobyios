//
//  annotationView.swift
//  bmobyios
//
//  Created by Oulachyov  on 10/6/16.
//  Copyright © 2016 bmoby. All rights reserved.
//

//************************************ CUSTOM ANNOTATION ***************************

import UIKit
import MapKit
import CoreLocation

class adressAnnotView: MKAnnotationView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // initializing the annotation with identifeir
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var frame = self.frame
        frame.size = CGSizeMake(80, 80)
        self.frame = frame
        self.backgroundColor = UIColor.clearColor()
        self.centerOffset = CGPointMake(-5, -5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        UIImage(named: "adressIcon")?.drawInRect(CGRectMake(30, 30, 30, 30))
    }
    
    
}
