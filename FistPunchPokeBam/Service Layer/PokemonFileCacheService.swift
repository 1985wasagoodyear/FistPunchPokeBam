//
//  PokemonFileCacheService.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/11/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation
import FileCache

// Adapter
class PokemonFileCacheService {
    
    var fileCache = FileCache()
    
    func getImage(_ pokemon: Pokemon) -> Data? {
        let name = pokemon.name + "_frontDefault"
        return fileCache.getImage(name)
    }
    
    func saveImage(_ pokemon: Pokemon, _ imageData: Data) {
        let name = pokemon.name + "_frontDefault"
        fileCache.saveImage(name, imageData)
    }
}
