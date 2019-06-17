//
//  GameStartViewModel.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/16/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

typealias PlayerInfo = (name: String, pokemonCount: Int, image: Data?)

class GameStartViewModel {
    
    var players: [Trainer] {
        didSet {
            updateUI()
        }
    }
    
    var numberOfPlayers: Int {
        return players.count
    }
    
    let updateUI: ()->Void
    
    init(_ updateUI: @escaping ()->Void) {
        self.updateUI = updateUI
        players = CoreDataService.shared.fetchAllTrainers()
    }
    
    func playerInfo(at index: Int) -> PlayerInfo {
        let player = players[index]
        let image = CoreDataService.shared.image(for: player)
        return (name: player.name,
                pokemonCount: player.pokemon.count,
                image: image)
    }
    
    func player(at index: Int) -> Trainer {
        return players[index]
    }
    
}
