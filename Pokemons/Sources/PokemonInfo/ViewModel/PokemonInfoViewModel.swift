//
//  PokemonInfoViewModel.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import Foundation

final class PokemonInfoViewModel {
    
    weak var view: PokemonInfoViewProtocol?
    private var coordinator: PokemonInfoCoordinatorProtocol?
    private var viewModel: PokemonInfoModel

    init(viewModel: PokemonInfoModel,
         coordinator: PokemonInfoCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
}

extension PokemonInfoViewModel: PokemonInfoViewModelProtocol {
    var pokemonViewModel: PokemonInfoModel { return viewModel }
}
