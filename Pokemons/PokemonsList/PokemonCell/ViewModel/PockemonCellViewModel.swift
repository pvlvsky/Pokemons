//
//  PockemonCellViewModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

final class PokemonCellViewModel: PokemonCellViewModelProtocol {

    private var pokemonModel: Pokemon
    
    init(pokemonModel: Pokemon) {
        self.pokemonModel = pokemonModel
    }
    
    var name: String {
        return pokemonModel.name
    }

    var url: String {
        return pokemonModel.id
    }
}
