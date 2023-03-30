//
//  AppCoordinator.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.showPokemonList()
    }
    
    private func showPokemonList() {
        let startCoordinator = PokemonListCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
