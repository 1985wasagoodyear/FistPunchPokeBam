//
//  Type+CoreDataClass.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Type)
public class Type: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case type = "name"
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
        guard let desc = NSEntityDescription.entity(forEntityName: "Type",
                                                    in: context)
            else {
                throw NSError(domain: "Description is bad",
                              code: 404,
                              userInfo: ["Errors":decoder.userInfo])
        }
        super.init(entity: desc, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
    }
}

