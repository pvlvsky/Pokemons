//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import Foundation
import UIKit

final class PokemonListViewModel {
    
    weak var view: PokemonsViewProtocol?
    private var pokemonList: [Pokemon] = []
    private var coordinator: PokemonListCoordinatorProtocol?
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService(),
         coordinator: PokemonListCoordinatorProtocol) {
        self.networkService = networkService
        self.coordinator = coordinator
    }
    
    private func updatePokemonList(with newList: [Pokemon]) {
        self.pokemonList.removeAll()
        self.pokemonList = newList
    }
    
    func showPokemonInfoVC(pokemonInfoModel: PokemonInfoModel) {
        coordinator?.showInfo(pokemonInfoModel: pokemonInfoModel)
    }
    
    func loadPokemonList() {
        networkService.loadPokemonsList { [weak self] list in
            guard let self = self,
                  let pokemonList = list.results else { return }
            
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
    
    var count: Int {
        return pokemonList.count
    }
    
    func getPokemonList() {
        loadPokemonList()
    }
    
    func getPokemon(id: String, showPokemonInfo: Bool = false) {
        networkService.loadPokemonInfo(id: id) { [weak self] pokemon in
            guard let self = self else { return }
            if showPokemonInfo {
                self.showPokemonInfoVC(pokemonInfoModel: pokemon)
                return
            }
            let pokemon = [Pokemon(name: pokemon.name, id: pokemon.id)]
            self.updatePokemonList(with: pokemon)
            self.view?.reloadCollectionView()
        }
    }

    func cellViewModelFor(indexPath: IndexPath) -> PokemonCellViewModel {
        let pokemon = loadPokemonInList(index: indexPath.row)
        return PokemonCellViewModel(pokemonModel: pokemon)
    }
    
    func openPockemonInfo(indexPath: IndexPath) {
        guard let id = loadPokemonInList(index: indexPath.row).id else { return }
        getPokemon(id: id, showPokemonInfo: true)
    }
}


