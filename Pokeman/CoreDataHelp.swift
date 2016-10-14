//
//  CoreDataHelp.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/11/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon() {
    
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Pidgey", imageName: "pidkey")
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Weedle", imageName: "weedle")
    createPokemon(name: "Zubat", imageName: "zubat")
    
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func createPokemon(name: String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokeman(context: context)
    
    pokemon.name = name
    pokemon.imageName = imageName
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func getAllPokemon() -> [Pokeman] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
        let pokemons = try context.fetch(Pokeman.fetchRequest()) as! [Pokeman]
        
        if pokemons.count == 0 {
            addAllPokemon()
            print("added pokemons\n")
            return getAllPokemon()
        } else {
            print("built pokemon array\n")
            return pokemons
        }
        
    } catch {}
    
    return []
}
