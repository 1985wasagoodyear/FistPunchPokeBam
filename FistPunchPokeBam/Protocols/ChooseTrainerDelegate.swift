//
//  ChooseTrainerDelegate.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

protocol ChooseTrainerDelegate {
    func choseTrainer(_ index: Int)
}

protocol TrainerCreationView {
    func finishedMakingTrainer(_ trainer: Trainer)
}
