//
//  GameStartViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/16/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

enum GameStartOptions: Int, CaseIterable {
    case trainers = 0, newGame
    
    static let allOptionsSize: Int = {
        GameStartOptions.allCases.count
    }()
}

class GameStartViewController: UIViewController {
    
    // MARK: - UI Properties

    var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "GameStartTableViewCell", bundle: nil)
            tableView.register(nib,
                               forCellReuseIdentifier: GameStartTableViewCell.cellID)
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView()
            tableView.setupToFill(superView: view)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    /// programmatic cell that will not be reused
    var newGameCell: UITableViewCell = {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "New Game!"
        cell.textLabel?.font = .pokeFont(size: 30.0)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }()
    
    // MARK: - Properties
    
    var viewModel: GameStartViewModel!
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        viewModel = GameStartViewModel {
            self.tableView?.reloadData()
        }
        tableView = UITableView(frame: view.frame, style: .plain)
    }
    
}

extension GameStartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = GameStartOptions(rawValue: indexPath.section)!
        switch option {
        case .trainers:
            didSelectTrainer(at: indexPath.row)
        case .newGame:
            didSelectNewGame()
        }
    }
    
    func didSelectTrainer(at index: Int) {
        let name = viewModel.playerInfo(at: index).name
        let startAdventure = {
            let trainer = self.viewModel.player(at: index)
            let vc = PokemonSafariViewController(trainer)
            self.navigationController?.setViewControllers([vc], animated: true)
        }
        showAlert(text: "Start Adventure with \(name)?", startAdventure)
    }
    
    func didSelectNewGame() {
        let startAdventure = {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TrainerPageViewController")
            self.navigationController?.setViewControllers([vc], animated: true)
        }
        showAlert(text: "Start A New Adventure?", startAdventure)
    }
    
    func showAlert(text: String,
                   _ okAction: (()->Void)? = nil,
                   _ cancelAction: (()->Void)? = nil) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let okHandler: ((UIAlertAction) -> Void)? = okAction != nil ? { _ in
            okAction?() } : nil
        let cancelHandler: ((UIAlertAction) -> Void)? = cancelAction != nil ? { _ in
            cancelAction?() } : nil
        let ok = UIAlertAction(title: "YES", style: .default, handler: okHandler)
        let cancel = UIAlertAction(title: "NO", style: .default, handler: cancelHandler)
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.preferredAction = ok
        self.present(alert, animated: true, completion: nil)
    }
}



extension GameStartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return GameStartOptions.allOptionsSize
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let option = GameStartOptions(rawValue: section)!
        switch option {
        case .trainers:
            return viewModel.numberOfPlayers
        case .newGame:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = GameStartOptions(rawValue: indexPath.section)!
        switch option {
        case .trainers:
            return trainerCell(tableView: tableView, indexPath: indexPath)
        case .newGame:
            return newGameCell
        }
    }
    
    func trainerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameStartTableViewCell.cellID,
                                                 for: indexPath) as! GameStartTableViewCell
        let playerInfo = viewModel.playerInfo(at: indexPath.row)
        if let im = playerInfo.image {
            cell.trainerImageView.image = UIImage(data: im)
        }
        else {
            cell.trainerImageView.image = UIImage(named: "chan")
        }
        cell.trainerNameLabel.text = " " + playerInfo.name
        cell.trainerSubtitleLabel.text = "\(playerInfo.pokemonCount) Pokemon Captured!"
        return cell
    }
    
    
}


