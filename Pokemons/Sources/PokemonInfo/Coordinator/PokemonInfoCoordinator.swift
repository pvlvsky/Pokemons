//
//  PokemonInfoCoordinator.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//
import UIKit

final class PokemonInfoCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    private var pokemonInfoModel: PokemonInfoModel

    init(navigationController: UINavigationController,
         pokemonInfoModel: PokemonInfoModel) {
        self.navigationController = navigationController
        self.pokemonInfoModel = pokemonInfoModel
    }
    
    func start() {
        let viewModel = PokemonInfoViewModel(viewModel: pokemonInfoModel, coordinator: self)
        let pokemonInfoVC = PokemonInfoVC(viewModel: viewModel)
        
        navigationController.pushViewController(pokemonInfoVC, animated: true)
    }
}

extension PokemonInfoCoordinator: PokemonInfoCoordinatorProtocol {}
