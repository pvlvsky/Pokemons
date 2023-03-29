//
//  PockemoneModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

struct PokemonListModel: Codable {
    var results: [Pokemon]
}

struct Pokemon: Codable {
    var name: String
    var id: String
}
