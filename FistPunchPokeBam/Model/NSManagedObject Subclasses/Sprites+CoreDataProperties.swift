//
//  Sprites+CoreDataProperties.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//
//

import Foundation
import CoreData


extension Sprites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sprites> {
        return NSFetchRequest<Sprites>(entityName: "Sprites")
    }

    @NSManaged public var backDefault: String?
    @NSManaged public var backFemale: String?
    @NSManaged public var backShiny: String?
    @NSManaged public var backShinyFemale: String?
    @NSManaged public var frontDefault: String?
    @NSManaged public var frontFemale: String?
    @NSManaged public var frontShiny: String?
    @NSManaged public var frontShinyFemale: String?
    @NSManaged public var pokemon: Pokemon

}
