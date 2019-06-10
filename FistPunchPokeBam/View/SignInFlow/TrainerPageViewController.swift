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
    var viewModel = TrainerViewModel()
    var currentIndex = 0
    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        loadVCs()
        
        // set our (visible) initial page content VC's for display
        setViewControllers([contentVCs[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    // MARK: - Setup Methods
    
    func loadVCs() {
        for name in viewModel.getAllTrainers() {
            let vc = TrainerContentVC.newFromStoryboard()
            vc.image = UIImage(named: name)
            contentVCs.append(vc)
        }
    }
}


extension TrainerPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // if we're showing the first one, do nothing
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        return contentVCs[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // if we're showing the last one, do nothing
        if currentIndex == contentVCs.count - 1 {
            return nil
        }
        
        currentIndex += 1
        return contentVCs[currentIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int  {
        return currentIndex
    }
}
