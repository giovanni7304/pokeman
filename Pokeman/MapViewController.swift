//
//  MapViewController.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/9/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
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
            setUp()
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            setUp()
        }
    }
    
    func setUp() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        manager.startUpdatingLocation()
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            //Spawn a Pokeman
            if let coord = self.manager.location?.coordinate {
                let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                let anotate = PokeAnnotation(coord: coord, pokemon: pokemon)
                anotate.coordinate = coord
                let randoLat = (Double(arc4random_uniform(200)) - 100.0) / 100000.0
                let randoLon = (Double(arc4random_uniform(200)) - 100.0) / 100000.0
                anotate.coordinate.latitude += randoLat
                anotate.coordinate.longitude += randoLon
                self.mapView.addAnnotation(anotate)
            }
        })

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            annoView.image = UIImage(named: "player")
        } else {
            let pokemon = (annotation as! PokeAnnotation).pokemon
            annoView.image = UIImage(named: pokemon.imageName!)
        }
        
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        
        annoView.frame = frame
        
        return annoView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        let pokemon = (view.annotation as! PokeAnnotation).pokemon
        
        if view.annotation! is MKUserLocation {
            print("User tapped")
        } else {
            let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, stdRadius, stdRadius)
            mapView.setRegion(region, animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                if let coord = self.manager.location?.coordinate {
                    if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coord)) {
                        print("Can Catch Pokemon")
                        
                        pokemon.caught = true
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        mapView.removeAnnotation(view.annotation!)
                        
                        let alertVC = UIAlertController(title: "Congrates", message: "You caught the \(pokemon.name!).  You are a Pokemon Master!", preferredStyle: .alert)
                        
                        let pokeDexAction = UIAlertAction(title: "PokeDex", style: .default, handler: {(action) in
                                self.performSegue(withIdentifier: "pokeDexSegue", sender: nil)
                        })
                            
                        alertVC.addAction(pokeDexAction)
                        
                        let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertVC.addAction(OKaction)
                        
                        self.present(alertVC, animated: true, completion: nil)
                        
                    } else {
                        let alertVC = UIAlertController(title: "uh-Oh", message: "You are too far away to catch the \(pokemon.name!).  Move closer to it!", preferredStyle: .alert)
                        let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertVC.addAction(OKaction)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    @IBAction func centerTapped(_ sender: AnyObject) {
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, stdRadius, stdRadius)
            mapView.setRegion(region, animated: true)
        }
    }
}

