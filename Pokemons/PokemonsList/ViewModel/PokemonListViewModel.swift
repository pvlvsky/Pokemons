//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation

final class PokemonListViewModel {
    
    weak var view: PokemonsViewProtocol?
    private var pokemonList: [Pokemon] = []
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    private func updatePokemonList(with newList: [Pokemon]) {
        self.pokemonList.removeAll()
        self.pokemonList = newList
    }
    
    func loadPokemonList() {
        networkService.loadPokemonsList { [weak self] list in
            guard let self = self,
                  let pokemonList = list.results
            else { return }
            
            //self.count = list.results.count
            self.updatePokemonList(with: pokemonList)
            self.view?.reloadCollectionView()
        }
    }
    
    private func loadPokemonInList(index: Int) -> Pokemon {
        updatePokemonId(index: index)
        return pokemonList[index]
    }
    
    private func updatePokemonId(index: Int) {
        guard !pokemonList.isEmpty && pokemonList[index].id == nil else { return }
        pokemonList[index].id = "\(index + 1)"
    }
    
    
}

extension PokemonListViewModel: PokemonListViewModelProtocol {
    
    func getPokemonList() {
        loadPokemonList()
    }
    
    var count: Int {
        return pokemonList.count
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> PokemonCellViewModel {
        let pokemon = loadPokemonInList(index: indexPath.row)
        return PokemonCellViewModel(pokemonModel: pokemon)
    }
}


