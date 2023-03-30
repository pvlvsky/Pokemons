//
//  PokemonListCoordinator.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import UIKit

final class PokemonListCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = PokemonListViewModel(coordinator: self)
        let pokemonListVC = PokemonsVC(viewModel: viewModel)
        navigationController.pushViewController(pokemonListVC, animated: true)
    }
}

extension PokemonListCoordinator: PokemonListCoordinatorProtocol {

    func showInfo(pokemonInfoModel: PokemonInfoModel) {
        let pokemonInfo = PokemonInfoCoordinator(
            navigationController: navigationController,
            pokemonInfoModel: pokemonInfoModel
        )
        coordinate(to: pokemonInfo)
    }
}
