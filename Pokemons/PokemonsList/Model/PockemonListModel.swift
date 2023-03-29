//
//  PockemoneModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

struct PokemonListModel: Codable {
    var results: [Pokemon]?
    
    init(results: [Pokemon]? = []) {
        self.results = results
    }
}
