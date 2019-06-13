//
//  PersistentService.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/13/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

class PersistentService {
    
    private let baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func save(data: Data, name: String) {
        let url = baseURL.appendingPathComponent(name)
        do {
            try data.write(to: url)
        }
        catch {
            print("Error writing: \(error)")
        }
    }
    
    func load(name: String) -> Data? {
        let url = baseURL.appendingPathComponent(name)
        do {
            return try Data(contentsOf: url)
        }
        catch {
            print("Error reading: \(error)")
            return nil
        }
    }
    
}
