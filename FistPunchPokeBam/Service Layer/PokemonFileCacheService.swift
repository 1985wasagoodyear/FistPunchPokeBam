//
//  PokemonFileCacheService.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/11/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

class PokemonFileCacheService {
    
    static let baseURL = FileManager.default.urls(for: .cachesDirectory,
                                                  in: .userDomainMask).first!
    
    func getImage(_ pokemon: Pokemon) -> Data? {
        let suffix = pokemon.name + "_frontDefault"
        let url = PokemonFileCacheService.baseURL.appendingPathComponent(suffix)
        do {
            let data = try Data(contentsOf: url)
            print("successfully got image from file cache")
            return data
        }
        catch {
            print("error, file not found")
        }
        return nil
    }
    
    func saveImage(_ pokemon: Pokemon, _ imageData: Data) {
        let suffix = pokemon.name + "_frontDefault"
        let url = PokemonFileCacheService.baseURL.appendingPathComponent(suffix)
        do {
            try imageData.write(to: url)
        }
        catch {
            print("Error saving image")
        }
    }
}
