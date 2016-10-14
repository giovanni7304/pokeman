//
//  MapViewController.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/9/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let stdRadius = 200 as CLLocationDistance
    var manager = CLLocationManager()
    var pokemons : [Pokeman] = []
    
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        pokemons = getAllPokemon()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready to Go")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //Spawn a Pokeman
                    if let coord = self.manager.location?.coordinate {
                        let anotate = MKPointAnnotation()
                        anotate.coordinate = coord
                        let randoLat = (Double(arc4random_uniform(200)) - 100.0) / 100000.0
                        let randoLon = (Double(arc4random_uniform(200)) - 100.0) / 100000.0
                        anotate.coordinate.latitude += randoLat
                        anotate.coordinate.longitude += randoLon
                        self.mapView.addAnnotation(anotate)
                    }
            })
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
        manager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("We Made It")
        
        if updateCount < 3 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, stdRadius, stdRadius)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }

    @IBAction func centerTapped(_ sender: AnyObject) {
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, stdRadius, stdRadius)
            mapView.setRegion(region, animated: true)
        }
    }
}

