//
//  UIFont+Utility.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/16/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func pokeFont(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Pokemon Hollow", size: size) else {
            fatalError("Fatal Error - \"Pokemon Hollow.tff\" not found!")
        }
        return font
    }
    
}
