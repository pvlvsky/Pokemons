//
//  PokemonInfoModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import Foundation

struct PokemonInfoModel: Codable {
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [Types]
    
    var idString: String { String(describing: id) }
    
    init(id: Int = 0,
         name: String = "",
         height: Int = 0,
         weight: Int = 0,
         types: [Types] = []) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.types = types
    }
}

struct Types: Codable {
    let type: `Type`
}

struct `Type`: Codable {
    let name: String
}
