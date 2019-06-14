//
//  PokemonCatchViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/14/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

let WIDTH: CGFloat = 500.0

class PokemonCatchViewController: UIViewController {
    
    // MARK: - UI Elements
    
    var pokemonImageView: UIImageView!
    var pokeballButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: PokemonCatchViewModel!
    
    // MARK: - Lifecycle Methods
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ vm: PokemonCatchViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = vm
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Need viewModel")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        let size = CGRect(x: 0, y: 0, width: WIDTH, height: WIDTH)
        let pokeballImage = UIImage(named: "beachball")!
        
        pokemonImageView = UIImageView(frame: size)
        pokemonImageView.image = pokeballImage // UIImage(data: viewModel.currentPokemonImage)
        pokemonImageView.contentMode = .scaleAspectFit
        
        pokeballButton = UIButton(type: .custom)
        pokeballButton.setImage(pokeballImage, for: .normal)
        pokeballButton.imageView?.contentMode = .scaleAspectFit
        
        view.addSubview(pokemonImageView)
        view.addSubview(pokeballButton)
        
        // constraints for pokemon image
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor,
                                                  constant: 30.0),
            pokemonImageView.widthAnchor.constraint(equalToConstant: WIDTH),
            pokemonImageView.heightAnchor.constraint(equalToConstant: WIDTH)
        ]
        NSLayoutConstraint.activate(constraints)
        
        // just place pokeball
        pokeballButton.center = view.center
        let imageSize = pokeballImage.size
        let x = view.center.x - (imageSize.width / 2.0)
        let y = view.frame.size.height - imageSize.height - 30.0
        pokeballButton.frame = CGRect(x: x,
                                      y: y,
                                      width: imageSize.width,
                                      height: imageSize.height)
    }
    
    
    
    
    
    
    
}
