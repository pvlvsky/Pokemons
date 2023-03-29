//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

final class PokemonListViewModel: PokemonListViewModelProtocol {
    
    var count: Int = 0
    weak var view: PokemonsViewProtocol?
    
    private var pokemonList: [Pokemon] = []
    var networkService: NetworkServiceProtocol = NetworkService()
    
    private func updatePokemonList(with newList: [Pokemon]) {
        self.pokemonList.removeAll()
        self.pokemonList = newList
        
    }
    
    func loadPokemonList() {
        networkService.loadPokemonsList { [weak self] list in
            guard let self = self else { return }
            let pokemonList = list.results
            self.count = list.results.count
            self.updatePokemonList(with: pokemonList)
            self.view?.reloadCollectionView()
        }
    }
    
    private func getPokemonInList(index: Int) -> Pokemon {
        updatePokemonId(index)
        return pokemonList[index]
    }
    
    private func updatePokemonId(_ index: Int) {
        guard !pokemonList.isEmpty && pokemonList[index].id == nil else { return }
        pokemonList[index].id = "\(index + 1)"
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> PokemonCellViewModel {
        let pokemon = getPokemonInList(index: indexPath.row)
        return PokemonCellViewModel(pokemonModel: pokemon)
    }
}
