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
    
    func loadPokemonList()
    func cellViewModelFor(indexPath: IndexPath) -> PokemonCellViewModel
}
