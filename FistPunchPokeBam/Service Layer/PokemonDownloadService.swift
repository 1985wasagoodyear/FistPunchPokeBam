//
//  PokemonDownloadService.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/11/19.
//  Copyright © 2019 KY. All rights reserved.
//

import Foundation

enum PokeApi: String {
    case pokemon = "https://pokeapi.co/api/v2/pokemon/"
}

extension PokeApi {
    func pokemonURL(_ name: String) -> URL? {
        return URL(string: PokeApi.pokemon.rawValue + name)
    }
    func pokemonURL(_ id: Int) -> URL? {
        return URL(string: PokeApi.pokemon.rawValue + "\(id)")
    }
}

class PokemonDownloadService {
    
    // NSURLConnection
    let session: URLSession
    let fileCache: PokemonFileCacheService
    var currentDownloads = [URL:URLSessionDataTask]()
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        
        fileCache = PokemonFileCacheService()
        // session = URLSession.shared
    }
    
    func downloadPokemon(_ name: String,
                         _ completionHandler: @escaping (Pokemon?)->Void) {
        if let url = PokeApi.pokemon.pokemonURL(name) {
            downloadPokemonHelper(url, completionHandler)
        }
        else {
            // throw an error
        }
    }
    
    func downloadPokemon(_ id: Int,
                         _ completionHandler: @escaping (Pokemon?)->Void) {
        guard let url = PokeApi.pokemon.pokemonURL(id) else {
            // throw an error & return
            return
        }
        downloadPokemonHelper(url, completionHandler)
    }
    /*
    HTTPS
    
    GET - query parameters, GETs data, returns stuff for you
    POST - put parameters into the body, POSTS data, can create or update data online
    PUT
    */
    // escaping & nonescaping
    func downloadPokemonHelper(_ url: URL,
                               _ completionHandler: @escaping (Pokemon?)->Void) {
        // we're currently already downloading for this url
        if currentDownloads[url] != nil { return }
        
        // paused, cancelled, finished, inprogress(?)
        let dataTask = session.dataTask(with: url) { (data, urlResponse, error) in
            guard let dat = data else { return }
            let pokemon = self.deserialize(dat)
            completionHandler(pokemon)
            self.currentDownloads.removeValue(forKey: url)
        }
        currentDownloads[url] = dataTask
        
        dataTask.resume()
    }
    
    func deserialize(_ data: Data) -> Pokemon? {
        let decoder = JSONDecoder()
        do {
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        }
        catch {
            print(error)
        }
        return nil
    }
    
    
    func downloadImage(_ pokemon: Pokemon,
                       _ completionHandler: @escaping (Data?)->Void) {

        // if image exists in filecache, get image
        if let image = fileCache.getImage(pokemon) {
            completionHandler(image)
            return
        }
        
        guard let urlString = pokemon.sprites.frontDefault,
              let url = URL(string: urlString) else {
                completionHandler(nil)
                return
        }
        
        if currentDownloads[url] != nil { return }
        // paused, cancelled, finished, inprogress(?)
        let dataTask = session.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data)
            self.currentDownloads.removeValue(forKey: url)
            
            // save image to the filecache
            if let dat = data {
                self.fileCache.saveImage(pokemon, dat)
            }
        }
        currentDownloads[url] = dataTask
        print("starting download for image")
        dataTask.resume()
    }
}

