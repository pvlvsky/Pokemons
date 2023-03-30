//
//  PokemonCellModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var id: String?
    
    init(name: String = "", id: Int = 0) {
        self.name = name
        self.id = String(describing: id)
    }
}
