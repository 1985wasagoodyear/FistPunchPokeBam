//
//  Sprites+CoreDataClass.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Sprites)
public class Sprites: NSManagedObject, Decodable {

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
    
    @objc
    private override init(entity: NSEntityDescription,
                          insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required public init(from decoder: Decoder) throws {
        let key = EncoderKey.contextKey
        guard let context = decoder.userInfo[key] as? NSManagedObjectContext else {
            print("could not find context")
            throw NSError(domain: "Context Not found",
                          code: 404,
                          userInfo: ["Errors":decoder.userInfo])
        }
        guard let desc = NSEntityDescription.entity(forEntityName: "Sprites",
                                                    in: context)
            else {
                throw NSError(domain: "Description is bad",
                              code: 404,
                              userInfo: ["Errors":decoder.userInfo])
        }
        super.init(entity: desc, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backDefault = try container.decodeIfPresent(String.self,
                                                forKey: .backDefault)
        backFemale = try container.decodeIfPresent(String.self,
                                               forKey: .backFemale)
        backShiny = try container.decodeIfPresent(String.self,
                                              forKey: .backShiny)
        backShinyFemale = try container.decodeIfPresent(String.self,
                                                    forKey: .backShinyFemale)
        frontDefault = try container.decodeIfPresent(String.self,
                                                 forKey: .frontDefault)
        frontFemale = try container.decodeIfPresent(String.self,
                                                forKey: .frontFemale)
        frontShiny = try container.decodeIfPresent(String.self,
                                               forKey: .frontShiny)
        frontShinyFemale = try container.decodeIfPresent(String.self,
                                                     forKey: .frontShinyFemale)
    }
        
}
