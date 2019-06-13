//
//  Pokemon.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/11/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

class Pokemon: Decodable {
    let name: String
    let sprites: Sprites
    let types: [Type]
    let weight: Int
    let height: Int
    
    enum PokeKeys: String, CodingKey {
        case name, sprites, types, weight, height
    }
    
    enum TypeKeys: String, CodingKey {
        case slot, type
    }
    
    enum TypeValKeys: String, CodingKey {
        case name, url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokeKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        weight = try container.decode(Int.self, forKey: .weight)
        height = try container.decode(Int.self, forKey: .height)
        var allTypes = [Type]()
        // decodes into arbitrary arrays
        var arrayContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        // while there are still items to decode in this array
        while !arrayContainer.isAtEnd {
            // decode into arbitrary dictionaries
            let typeContainer = try arrayContainer.nestedContainer(keyedBy: TypeKeys.self)
            let type = try typeContainer.decode(Type.self, forKey: .type)
            allTypes += [type]
        }
        types = allTypes
    }
}

// this will be exciting in the future
class Type: Decodable {
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case type = "name"
    }
}

class Sprites: Decodable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}
