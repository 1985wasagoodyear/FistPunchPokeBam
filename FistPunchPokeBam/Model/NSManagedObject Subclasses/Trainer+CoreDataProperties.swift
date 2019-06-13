//
//  Trainer+CoreDataProperties.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//
//

import Foundation
import CoreData


extension Trainer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trainer> {
        return NSFetchRequest<Trainer>(entityName: "Trainer")
    }

    @NSManaged public var name: String
    @NSManaged public var image: String
    @NSManaged public var pokemon: NSOrderedSet

}

// MARK: Generated accessors for pokemon
extension Trainer {

    @objc(addPokemonObject:)
    @NSManaged public func addToPokemon(_ value: Pokemon)

    @objc(removePokemonObject:)
    @NSManaged public func removeFromPokemon(_ value: Pokemon)

    @objc(addPokemon:)
    @NSManaged public func addToPokemon(_ values: NSSet)

    @objc(removePokemon:)
    @NSManaged public func removeFromPokemon(_ values: NSSet)

}
