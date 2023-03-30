//
//  NetworkService.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    enum fetchErrors: Error {
        case 
    }

    func loadPokemonsList(completion: @escaping (PokemonListModel) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/pokemon"
        urlComponents.queryItems = [URLQueryItem(name: "offset", value: "0"),
                                    URLQueryItem(name: "limit", value: "50")]
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let jsonData = data {
                print(jsonData)
                let pokemonsList = try? JSONDecoder().decode(PokemonListModel.self, from: jsonData)
               
                DispatchQueue.main.async {
                    guard let pokemonsList = pokemonsList else { return }
                    completion(pokemonsList)
                    print(pokemonsList)
                }
            }
        }.resume()
    }
    
    func loadPokemonInfo(id: String, completion: @escaping (PokemonInfoModel) -> ()) {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/pokemon/" + id
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let jsonData = data {
                let pokemonInfo = try? JSONDecoder().decode(PokemonInfoModel.self, from: jsonData)
                
                DispatchQueue.main.async {
                    guard let pokemonInfo = pokemonInfo else { return }
                    completion(pokemonInfo)
                    print(pokemonInfo)
                }
            }
        }.resume()
    }
}
