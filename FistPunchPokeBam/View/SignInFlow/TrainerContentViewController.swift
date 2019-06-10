//
//  TrainerContentViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

class TrainerContentViewController: UIViewController {
    
    // MARK: - Storyboard Outlets
    
    @IBOutlet var trainerImageView: UIImageView!
    @IBOutlet var trainerSelectButton: UIButton!
    
    // MARK: - Properties
    
    var image: UIImage?

    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainerImageView.image = image
    }
    
    // MARK: - Custom Action Methods
    
    @IBAction func trainerSelectAction(_ sender: Any) {
        
    }

}

extension TrainerContentViewController {
    static func newFromStoryboard() -> TrainerContentViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrainerContentVC") as! TrainerContentViewController
        return vc
    }
}
