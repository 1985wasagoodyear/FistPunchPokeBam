//
//  Type+CoreDataProperties.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//
//

import Foundation
import CoreData


extension Type {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Type> {
        return NSFetchRequest<Type>(entityName: "Type")
    }

    @NSManaged public var type: String
    @NSManaged public var pokemon: NSSet

}

// MARK: Generated accessors for pokemon
extension Type {

    @objc(addPokemonObject:)
    @NSManaged public func addToPokemon(_ value: Pokemon)

    @objc(removePokemonObject:)
    @NSManaged public func removeFromPokemon(_ value: Pokemon)

    @objc(addPokemon:)
    @NSManaged public func addToPokemon(_ values: NSSet)

    @objc(removePokemon:)
    @NSManaged public func removeFromPokemon(_ values: NSSet)

}
