//
//  TrainerCreationViewModel.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

class TrainerCreationViewModel {
    
    var view: TrainerCreationView
    
    init(view: TrainerCreationView) {
        self.view = view
    }
    
    func choseTrainer(_ name: String, _ picture: Data) {
        let service = CoreDataService.shared
        let trainer = service.makeTrainer(name: name, image: picture)
        view.finishedMakingTrainer(trainer)
    }
    
    func getAllTrainers() -> [String] {
        return Constants.trainers
    }
    
}
