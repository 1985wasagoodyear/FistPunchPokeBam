//
//  Trainer.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

class Badge { }

class Trainer {
    var name: String
    var image: Data
    
    var pokemon = [Pokemon]()
    var storedPokemon = [Pokemon]()
    
    var battlesCount = 0
    var badges = [Badge]()
    
    var monies = 0
    
    init(name: String, image: Data) {
        self.name = name
        self.image = image
    }
}

// computed helper-properties
extension Trainer {
    var numOfPokemon: Int {
        return pokemon.count
    }
    
    var numOfStoredPokemon: Int {
        return storedPokemon.count
    }
}
