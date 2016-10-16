//
//  PokeDexViewController.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/11/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit

class PokeDexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var caughtPokemon : [Pokeman] = []
    var uncaughtPokemon : [Pokeman] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        caughtPokemon = getAllCaughtPokemons()
        uncaughtPokemon = getAllUnCaughtPokemons()
    
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "CAUGHT"
        } else {
            return "UNCAUGHT"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokemon.count
        } else {
            return uncaughtPokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon : Pokeman
        
        if indexPath.section == 0 {
            pokemon = caughtPokemon[indexPath.row]
        } else {
            pokemon = uncaughtPokemon[indexPath.row]
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        
        return cell
    }
    
    @IBAction func mapTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
