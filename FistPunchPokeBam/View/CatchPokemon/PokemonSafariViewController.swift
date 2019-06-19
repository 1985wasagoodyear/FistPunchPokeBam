//
//  PokemonSafariViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

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
        let updateUI: ()->Void = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        viewModel = PokemonCatchViewModel(trainer, updateUI)
        downloadPokemon()
    }
    func downloadPokemon() {
        viewModel.downloadRandomPokemon(count: 12)
    }
}

extension PokemonSafariViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.count // NUMBER_OF_CHANS
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_CELL_ID, for: indexPath) as! PokemonCollectionViewCell
        // what is the information I need to display?
    
        if let imageData = viewModel.image(at: indexPath.row) {
            cell.imageView.image = UIImage(data: imageData)
        }
        else {
            // placeholder if no data exists
            cell.imageView.image = UIImage(named: "john")
        }
        
        return cell
    }

}

extension PokemonSafariViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.startedCatchingPokemon(at: indexPath.row)
        let catchVC = PokemonCatchViewController(viewModel)
        present(catchVC, animated: true, completion: nil)
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
