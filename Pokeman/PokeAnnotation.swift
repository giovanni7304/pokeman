//
//  PokeAnnotation.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/16/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokeman
    
    init(coord: CLLocationCoordinate2D, pokemon: Pokeman) {
        self.coordinate = coord
        self.pokemon = pokemon
        
    }
    
    
    
    
}
