//
//  CoreDataHelp.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/11/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import CoreData

func createPokemon(name: String, imageName: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokeman(context: context)
    
    pokemon.name = name
    pokemon.imageName = imageName
    
}
