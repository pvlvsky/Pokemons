//
//  PokemonsView+Extension.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

extension PokemonsView: PokemonsViewProtocol {

    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension PokemonsView: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PokemonViewCell.self)", for: indexPath) as? PokemonViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: viewModel.cellViewModelFor(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openPockemonInfo(indexPath: indexPath)
    }
}

extension PokemonsView {
    
    func buildView() {
        additionalSetup()
        setupSubviews()
        setupConstraints()
    }

    func additionalSetup() {
        backgroundColor = .white
    }
    
    func setupSubviews() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
