//
//  PokemonListViewModelProtocol.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

protocol PokemonListViewModelProtocol {
    
    var view: PokemonsViewProtocol? { get set }
    var count: Int { get }
    func cellViewModelFor(indexPath: IndexPath) -> PokemonCellViewModel
    func getPokemonList()
    func getPokemon(id: String, showPokemonInfo: Bool)
    func openPockemonInfo(indexPath: IndexPath)
}
