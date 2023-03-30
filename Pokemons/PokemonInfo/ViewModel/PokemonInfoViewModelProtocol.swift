//
//  PokemonInfoViewModelProtocol.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import Foundation

protocol PokemonInfoViewModelProtocol {
    var view: PokemonInfoViewProtocol? { get set }
    var pokemonViewModel: PokemonInfoModel { get }
}
