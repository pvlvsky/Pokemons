//
//  PokemonsVC.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

class PokemonsVC: UIViewController {

    var viewModel: PokemonListViewModelProtocol!
    private var pokemonView: PokemonsView!
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        self.pokemonView = PokemonsView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = pokemonView
        self.pokemonView.frame = view.frame
        self.pokemonView.center = view.center
        title = "Pokemons"
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadPokemonList()
    }
}
