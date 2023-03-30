//
//  PokemonsView.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

final class PokemonsView: UIView {

    var viewModel: PokemonListViewModelProtocol

    init(viewModel: PokemonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.view = self
        buildView()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        view.register(PokemonViewCell.self, forCellWithReuseIdentifier: "PokemonViewCell")
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        if #available(iOS 16.0, *) {
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        } else {
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
    }
}



