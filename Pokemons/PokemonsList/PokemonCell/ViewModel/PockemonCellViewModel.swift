//
//  PockemonCellViewModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

final class PokemonCellViewModel {
    
    private var pokemonModel: PokemonCellModel
    
    init(pokemonModel: PokemonCellModel) {
        self.pokemonModel = pokemonModel
    }
    
    var name: String {
        return pokemonModel.name
    }

    var id: String {
        return pokemonModel.id
    }
}
