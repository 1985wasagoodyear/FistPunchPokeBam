//
//  CoreDataService.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation
import CoreData

// Singleton
// there exists only one instance at a time
// trying to make another returns the same instance

// traits: life-long, cannot be destroyed, global

// this is a Creational pattern -
// desc. how to make an object

// this is an anti-pattern, it's a global variable

// Making a Singleton in Swift:
// 1. not allow the user to make another instance
// 2. have an instance that's global for use
// 3. ???
// 4. Profit.

// 1. don't let them subclass this
final class CoreDataService {
    
    // 2. global instance for use
    static let shared = CoreDataService()

    // 3. not allow user to make another instance
    // access control modifiers
    private init() {
        persistentService = PersistentService()
    }
    
    
    // MARK: - Additional Properties
    
    var persistentService: PersistentService
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
}

// MARK: - Trainer

extension CoreDataService {
    func makeTrainer(name: String, image: Data) -> Trainer {
        // make the trainer
        let trainer = NSEntityDescription.insertNewObject(forEntityName: "Trainer",
                                                       into: mainContext) as! Trainer
        // save the picture to the filesystem
        // & create filename for picture for use
        let fileName = name + "_profile"
        persistentService.save(data: image, name: fileName)
        
        trainer.name = name
        trainer.image = fileName
        
        // save the trainer
        saveContext()
        
        return trainer
    }
    
    func trainerExists() -> Bool {
        // check core data if a trainer exists
        let trainer: NSFetchRequest<Trainer> = Trainer.fetchRequest()
        trainer.fetchLimit = 1
        do {
            let results = try mainContext.fetch(trainer)
            return !results.isEmpty
        }
        catch {
            print("Error finding trainer: \(error)")
        }
        return false
    }
    func fetchTrainer() -> Trainer? {
        // check core data if a trainer exists
        let trainer: NSFetchRequest<Trainer> = Trainer.fetchRequest()
        trainer.fetchLimit = 1
        do {
            let results = try mainContext.fetch(trainer)
            return results.first
        }
        catch {
            print("Error finding trainer: \(error)")
        }
        return nil
    }
    
    func fetchAllTrainers() -> [Trainer] {
        // check core data if a trainer exists
        let trainer: NSFetchRequest<Trainer> = Trainer.fetchRequest()
        do {
            let results = try mainContext.fetch(trainer)
            return results
        }
        catch {
            print("Error finding trainer: \(error)")
        }
        return []
    }
    
    func image(for trainer: Trainer) -> Data? {
        return persistentService.load(name: trainer.image)
    }
    
}

// MARK: - Pokemon

extension CoreDataService {
    
    
}
