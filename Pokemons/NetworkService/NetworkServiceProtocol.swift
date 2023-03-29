//
//  NetworkServiceProtocol.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadPokemonsList(completion: @escaping (PokemonListModel) -> ())
}
