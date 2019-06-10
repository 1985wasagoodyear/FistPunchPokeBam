//
//  PokemonCollectionViewCell.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
}

extension PokemonCollectionViewCell {
    static func register(id: String,
                         collectionView: UICollectionView) {
        let nib = UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: id)
    }
}
