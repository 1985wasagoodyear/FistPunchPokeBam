//
//  PokemonCaptureViewModel.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/11/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

// define interface to update
// define means of interacting with interface
class PokemonCatchViewModel {
    var trainer: Trainer
    
    var safariPokemon = [Pokemon]()
    var count: Int {
        return safariPokemon.count
    }
    var currentPokemon: (index: Int, mon: Pokemon)?
    
    var service = PokemonDownloadService()
    
    let updateUI: ()->Void
    
    init(_ trainer: Trainer, _ updateUI: @escaping ()->Void) {
        self.trainer = trainer
        self.updateUI = updateUI
    }
    
    // MARK: - Business Logic for Capturing
    
    func startedCatchingPokemon(at index: Int) {
        currentPokemon = (index: index, mon: safariPokemon[index])
    }
    
    func didCaptureCurrentPokemon() {
        let current = currentPokemon!
        trainer.addToPokemon(current.mon)
        safariPokemon.remove(at: current.index)
        currentPokemon = nil
        CoreDataService.shared.saveContext()
    }
    
    // MARK: - Interfaces for Presentation Data
    
    func image(at index: Int) -> Data? {
        let mon = safariPokemon[index]
        if let image = service.fileCache.getImage(mon) {
            return image
        }
        else {
            downloadPokemonImage(mon)
        }
        return nil
    }
    
    func currentPokemonImage() -> Data {
        return service.fileCache.getImage(currentPokemon!.mon)!
    }
    
    // MARK: - Download Tasks
    
    func downloadPokemon(_ name: String) {
        service.downloadPokemon(name) { (pokemon) in
            guard let mon = pokemon else { return }
            self.safariPokemon.append(mon)
            self.updateUI()
        }
    }
    func downloadPokemon(_ id: Int) {
        service.downloadPokemon(id) { (pokemon) in
            if let mon = pokemon {
                self.safariPokemon.append(mon)
                print("downloaded a pokemon")
                self.updateUI()
            }
        }
    }
    
    // hold-off on the updating until some batch-work is completed.
    func downloadRandomPokemon(count: Int) {
        // "group" a bunch of long-running tasks together as a single unit
        // enter - put tasks inside the group
        // leave - have tasks exit the group
        // when enter's and leave's match, we are done and 'notify' the group
        let group = DispatchGroup()
        var tempPokemon = [Pokemon]()
        
        // start downloads for count-many pokemon
        for i in 0..<count {
            let id = Int.random(in: 1...251)
            group.enter()
            service.downloadPokemon(id) { [i] (pokemon) in
                guard let mon = pokemon else {
                    print("failed to download \(i)")
                    group.leave()
                    return
                }
                tempPokemon.append(mon)
                group.leave()
            }
        }
        
        // ONLY AFTER all downloads are completed
        // we update the ui
        group.notify(queue: DispatchQueue.main, execute: {
            self.safariPokemon = tempPokemon
            self.updateUI()
            print("did notify")
        })
    }
    
    func downloadPokemonImage(_ pokemon: Pokemon) {
        if let _ = service.fileCache.getImage(pokemon) {
            self.updateUI()
            return
        }
        service.downloadImage(pokemon) { image in
            if let im = image {
                self.service.fileCache.saveImage(pokemon, im)
                DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                    self.updateUI()
                }
            }
            else {
                print("no data found")
            }
        }
    }
}
