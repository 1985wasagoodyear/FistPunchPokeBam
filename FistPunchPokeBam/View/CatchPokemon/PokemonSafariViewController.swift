//
//  PokemonSafariViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

class PokemonCatchViewModel {
    var trainer: Trainer
    init(_ trainer: Trainer) {
        self.trainer = trainer
    }
}

/*
 1. Demonstrate CollectionView
 2. Hook up VM to View
 3. Download Pokemon
 */

class PokemonSafariViewController: UIViewController {
    
    // MARK: - Constants
    
    let NUMBER_OF_CHANS: Int = 22
    let COLLECTION_CELL_ID = "pokemonCell"
    
    var collectionView: UICollectionView!
    var viewModel: PokemonCatchViewModel!
    
    init(_ trainer: Trainer) {
        super.init(nibName: nil, bundle: nil)
        setupWithTrainer(trainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .main
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.setupToFill(superView: view)
        collectionView.dataSource = self
        collectionView.delegate = self
        PokemonCollectionViewCell.register(id: COLLECTION_CELL_ID,
                                           collectionView: collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    func setupWithTrainer(_ trainer: Trainer) {
        viewModel = PokemonCatchViewModel(trainer)
    }
}

extension PokemonSafariViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return NUMBER_OF_CHANS // return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_CELL_ID, for: indexPath) as! PokemonCollectionViewCell
        cell.imageView.image = UIImage(named: "chan")
        return cell
    }

}

extension PokemonSafariViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 3.0
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}