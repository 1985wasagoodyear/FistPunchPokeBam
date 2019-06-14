//
//  PokemonCatchViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/14/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit
import Disintegrate

let WIDTH: CGFloat = 500.0
let WIDTH_RATIO: CGFloat = 0.66

extension CGSize {
    static func /(lhs: CGSize, rhs: Double) -> CGSize {
        return CGSize(width: lhs.width / CGFloat(rhs),
                      height: lhs.height / CGFloat(rhs))
    }
    static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs,
                      height: lhs.height / rhs)
    }
}

extension UIImage {
    static let beachball: UIImage = {
        return UIImage(named: "beachball")!
    }()
}

class PokemonCatchViewController: UIViewController {
    
    // MARK: - UI Elements
    
    var pokemonImageView: UIImageView! {
        // Property-observers
        willSet { }
        didSet {
            pokemonImageView.image = /*.beachball*/ UIImage(data: viewModel.currentPokemonImage())
            pokemonImageView.contentMode = .scaleAspectFit
            
            // constraints for pokemon image
            view.addSubview(pokemonImageView)
            pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor,
                                                      constant: 30.0),
                pokemonImageView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                        multiplier: WIDTH_RATIO),
                NSLayoutConstraint.init(item: pokemonImageView as Any,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: pokemonImageView,
                                        attribute: .height,
                                        multiplier: 1.0, constant: 0.0)
            ]
            NSLayoutConstraint.activate(constraints)
        }
    }
    var pokeballButton: UIButton! {
        didSet {
            pokeballButton.setImage(.beachball, for: .normal)
            pokeballButton.imageView?.contentMode = .scaleAspectFit
            pokeballButton.addTarget(self,
                                     action: #selector(catchAction),
                                     for: .touchUpInside)
            view.addSubview(pokeballButton)
            // just place pokeball
            pokeballButton.center = view.center
            let imageSize = UIImage.beachball.size / 2.0
            let x = view.center.x - (imageSize.width / 2.0)
            let y = view.frame.size.height - imageSize.height - 30.0
            pokeballButton.frame = CGRect(x: x,
                                          y: y,
                                          width: imageSize.width,
                                          height: imageSize.height)
        }
    }
    
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
        pokemonImageView = UIImageView(frame: size)
        pokeballButton = UIButton(type: .custom)
    }
    
    @objc func catchAction() {
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        // Animation's path
        let path = UIBezierPath()
        let startPos = pokeballButton.center
        let endPos = pokemonImageView.center
        
        // Move the "cursor" to the start
        path.move(to: startPos)
        
        // Calculate the control points
        let c1 = CGPoint(x: startPos.x + 128,
                         y: startPos.y)
        let c2 = CGPoint(x: endPos.x + 128,
                         y: endPos.y/* - 256*/)
        
        // Draw a curve towards the end, using control points
        path.addCurve(to: endPos, controlPoint1: c1, controlPoint2: c2)
        
        // Use this path as the animation's path (casted to CGPath)
        animation.path = path.cgPath;
        
        // The other animations properties
        animation.fillMode              = .forwards
        // what we do with the animation on completion
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        animation.duration              = 2.0
        animation.timingFunction        = CAMediaTimingFunction(name: .easeIn)
        
        // Apply it
        pokeballButton.layer.add(animation, forKey: "pokeballMove")

    }
    
    func pokemonIsCaughtAnimation() {
        let comp: ()->Void = {
            // add the pokemon to the trainer
            // remove the captured pokemon from the screen
            self.viewModel.didCaptureCurrentPokemon()
            // return to the safari screen
            self.dismiss(animated: true, completion: nil)
        }
        pokemonImageView.disintegrate(direction: .random(),
                                      estimatedTrianglesCount: 100,
                                      completion: comp)
    }
    
}

extension PokemonCatchViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        let moveAnimation = pokeballButton.layer.animation(forKey: "pokeballMove")
        if flag == true && anim == moveAnimation {
            pokeballButton.layer.removeAnimation(forKey: "pokeballMove")
            pokeballButton.isHidden = true
            pokemonIsCaughtAnimation()
        }
        
    }
}
