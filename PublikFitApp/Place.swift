//
//  Places.swift
//  PublikFitApp
//
//  Created by Breno Ramos on 07/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
     init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
