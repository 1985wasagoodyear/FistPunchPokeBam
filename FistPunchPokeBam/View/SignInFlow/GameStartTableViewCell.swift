//
//  GameStartTableViewCell.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/16/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

class GameStartTableViewCell: UITableViewCell {
    
    // MARK: - XIB Outlets
    
    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 10.0
            containerView.layer.borderWidth = 4.0
            containerView.layer.borderColor = UIColor(red: 0.0/255.0,
                                                      green: 191.0/255.0,
                                                      blue: 255.0/255.0,
                                                      alpha: 1.0).cgColor
            containerView.backgroundColor = UIColor(red: 135.0/255.0,
                                                    green: 206/255.0,
                                                    blue: 250.0/255.0,
                                                    alpha: 1.0)
            backgroundColor = .clear
        }
    }
    @IBOutlet var trainerImageView: UIImageView!
    
    @IBOutlet var trainerNameLabel: UILabel! {
        didSet {
            trainerNameLabel.font = .pokeFont(size: 50.0)
        }
    }
    
    @IBOutlet var trainerSubtitleLabel: UILabel! {
        didSet {
            trainerNameLabel.font = .pokeFont(size: 30.0)
        }
    }
}

extension GameStartTableViewCell {
    static let cellID: String = {
        return "GameStartTableViewCell"
    }()
}
