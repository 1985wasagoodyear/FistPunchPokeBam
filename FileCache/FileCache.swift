//
//  FileCache.swift
//  FileCache
//
//  Created by K Y on 6/17/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

extension Data {
    var ns: NSData {
        return NSData(data: self)
    }
}

extension String {
    var ns: NSString {
        return NSString(string: self)
    }
}

/*
Access Controls in Swift
    open, public, internal, fileprivate, private
 
 in order of least-restrictive to most-restrictive:
    open - anyone can use it, anyone can redefine it
    public - anyone can use it, no one outside the module refine
    internal - default, usable in module
    fileprivate - usable only within the declaring file
    private - usable only within the scope
*/

class Foo {
    private var a: Int = 8
    fileprivate var b: Int = 10
}

extension Foo {
    // Swift 3, this would NOT be allowed
    // Swift 4, can use privates in extensions, within the same file
    func printA() {
        print(a)
    }
    // this will work
    func printB() {
        print(b)
    }
}


open class FileCache {
    static private let baseURL = FileManager.default.urls(for: .cachesDirectory,
                                                  in: .userDomainMask).first!
    
    private var inMemoryCache = NSCache<NSString, NSData>()
    
    public init() { }
    
    /*
     Step 1: check in-memory cache, return if it exists
     Step 2: check filesystem, return if it exists
     Step 3: return nil, because it doesn't exist
     */
    open func getImage(_ name: String) -> Data? {
        
        // Step 1.
        if let dat = inMemoryCache.object(forKey: name.ns) {
            return Data(referencing: dat)
        }
        // Step 2
        else {
            let url = FileCache.baseURL.appendingPathComponent(name)
            do {
                let data = try Data(contentsOf: url)
                return data
            }
            catch {
                print("error: \(error)")
            }
        }
        // Step 3
        return nil
    }
    
    open func saveImage(_ name: String, _ imageData: Data) {
        // save to in-memory cache
        inMemoryCache.setObject(imageData.ns, forKey: name.ns)
        // save to disk system cache
        let url = FileCache.baseURL.appendingPathComponent(name)
        do {
            try imageData.write(to: url)
        }
        catch {
            print("Error saving image")
        }
    }
}
