//
//  PokemonViewCell+Extension.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

extension PokemonViewCell {
    
    func setupCell(viewModel: PokemonCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.nameLabel.font = UIFont.systemFont(ofSize: 14)
        self.idLabel.text = "ID:\(viewModel.url)"
        setImage(id: viewModel.url)
    }
    
    func setupImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
        return imageView
    }
    
    func setupNameLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        return label
    }
    
    func setupIdLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.tintColor = .white
        label.textAlignment = .center
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
        return label
    }
}
