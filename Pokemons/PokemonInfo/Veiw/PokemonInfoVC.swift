//
//  PokemonInfoVC.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import UIKit

final class PokemonInfoVC: UIViewController {
        
    private var viewModel: PokemonInfoViewModelProtocol!
    private var contentView: PokemonInfoView!

    init(viewModel: PokemonInfoViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = PokemonInfoView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = contentView
    }
}

