//
//  PokemonsView.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

final class PokemonsView: UIView {
    
    var viewModel: PokemonListViewModelProtocol
    
    lazy var collectionView = setupCollectionView()
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


