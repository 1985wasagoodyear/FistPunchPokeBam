//
//  TrainerPageViewController.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

/*
    Load all the ContentVC's and add in their images
 
    Have a way to determine when a VC is selected
 
    Go to Signed-In experience when selected.
 
 */

import UIKit

typealias TrainerContentVC = TrainerContentViewController

class TrainerPageViewController: UIPageViewController {

    // MARK: - Properties
    
    var contentVCs = [TrainerContentVC]()
    var viewModel: TrainerCreationViewModel!
    // var currentIndex = 0
    // var animationDirection: NavigationDirection = .forward
    
    // MARK: - UIViewController Lifecycle Methods
    
    override func loadView() {
        super.loadView()
        viewModel = TrainerCreationViewModel(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVCs()
        
        dataSource = self
        delegate = self
        
        // set our (visible) initial page content VC's for display
        setViewControllers([contentVCs[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    // MARK: - Setup Methods
    
    func loadVCs() {
        let trainerNames = viewModel.getAllTrainers()
        for (i, name) in trainerNames.enumerated() {
            let vc = TrainerContentVC.newFromStoryboard()
            vc.image = UIImage(named: name)
            vc.index = i
            vc.delegate = self
            contentVCs.append(vc)
        }
    }
}

extension TrainerPageViewController: TrainerCreationView {
    func finishedMakingTrainer(_ trainer: Trainer) {
        let pokemonVC = PokemonSafariViewController(trainer)
        let nav = UINavigationController(rootViewController: pokemonVC)
        present(nav, animated: true, completion: nil)
    }
}

extension TrainerPageViewController: ChooseTrainerDelegate {
    func choseTrainer(_ index: Int) {
        if index == 3 {
            // do something else, for custom character
        }
        let vc = contentVCs[index]
        guard let im = vc.image,
              let image = im.pngData()
              else {
            print("Error, image not found")
            return
        }
        let name = viewModel.getAllTrainers()[index]
        viewModel.choseTrainer(name, image)
    }
}

extension TrainerPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! TrainerContentVC).index
        
        // if we're showing the first one, do nothing
        if currentIndex == 0 {
            return nil
        }
        
        //animationDirection = .reverse
        return contentVCs[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! TrainerContentVC).index
        
        // if we're showing the last one, do nothing
        if currentIndex == contentVCs.count - 1 {
            return nil
        }
        
        //animationDirection = .forward
        return contentVCs[currentIndex + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let vcs = viewControllers,
              let first = vcs.first as? TrainerContentVC
              else { return 0 }
        
        return first.index
    }
}


extension TrainerPageViewController: UIPageViewControllerDelegate {
    /*
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            // change our index
            if animationDirection == .forward {
                currentIndex += 1
            }
            else {
                currentIndex -= 1
            }
        }
    }
    */
}
