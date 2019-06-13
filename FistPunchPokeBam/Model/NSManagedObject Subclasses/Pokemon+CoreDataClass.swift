//
//  Pokemon+CoreDataClass.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Pokemon)
public class Pokemon: NSManagedObject, Decodable {
    
    enum PokeKeys: String, CodingKey {
        case name, sprites, types, weight, height
    }
    
    enum TypeKeys: String, CodingKey {
        case slot, type
    }
    
    required public init(from decoder: Decoder) throws {
        
        let key = EncoderKey.contextKey
        guard let context = decoder.userInfo[key] as? NSManagedObjectContext else {
            print("could not find context")
            throw NSError(domain: "Context Not found",
                          code: 404,
                          userInfo: ["Errors":decoder.userInfo])
        }
        guard let desc = NSEntityDescription.entity(forEntityName: "Pokemon",
                                                    in: context)
            else {
                throw NSError(domain: "Description is bad",
                              code: 404,
                              userInfo: ["Errors":decoder.userInfo])
        }
        super.init(entity: desc, insertInto: context)
        
        let container = try decoder.container(keyedBy: PokeKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        weight = Int32(try container.decode(Int.self, forKey: .weight))
        height = Int32(try container.decode(Int.self, forKey: .height))
        
        let allTypes = NSMutableOrderedSet()
        // decodes into arbitrary arrays
        var arrayContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        // while there are still items to decode in this array
        while !arrayContainer.isAtEnd {
            // decode into arbitrary dictionaries
            let typeContainer = try arrayContainer.nestedContainer(keyedBy: TypeKeys.self)
            let type = try typeContainer.decode(Type.self, forKey: .type)
            allTypes.add(type)
        }
        types = allTypes
    }
}
