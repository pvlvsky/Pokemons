//
//  PokemonInfoView.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 30.03.23.
//

import UIKit

final class PokemonInfoView: UIView {

    private var viewModel: PokemonInfoViewModelProtocol

    init(viewModel: PokemonInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.view = self
        //buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var heightDescription: PokemonInfoDescriptionView = {
        return PokemonInfoDescriptionView(title: "Height")
    }()
    
    private lazy var weightDescription: PokemonInfoDescriptionView = {
        return PokemonInfoDescriptionView(title: "Weight")
    }()
    
    private lazy var typesDescription: PokemonInfoDescriptionView = {
        return PokemonInfoDescriptionView(title: "Types")
    }()

    private func setImage(id: String) {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") else { return }
        ImageCache.getImage(with: url) { [weak self] (image) in
            guard let self = self,
                  let image = image else { return }
            self.imageView.image = image
        }
    }
    
    private func configure() {
        let pokemonInfo = viewModel.pokemonViewModel
        let types = pokemonInfo.types.map({$0.type.name.capitalized}).joined(separator: ", ")
        let weight = String(format: "%.1fkg", Double(pokemonInfo.weight) / 10.0)
        let height = String(format: "%.1fm", Double(pokemonInfo.height) / 10.0)

        nameLabel.text = pokemonInfo.name.capitalized
        idLabel.text = "ID:\(pokemonInfo.id)"
        heightDescription.setText(height)
        weightDescription.setText(weight)
        typesDescription.setText(types)
        setImage(id: pokemonInfo.idString)
    }
}

extension PokemonInfoView: PokemonInfoViewProtocol {}

extension PokemonInfoView {

    func setupHierarchy() {
        addSubview(imageView)
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(heightDescription)
        addSubview(weightDescription)
        addSubview(typesDescription)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200.0)
        ])

        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            heightDescription.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16.0),
            heightDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            weightDescription.topAnchor.constraint(equalTo: heightDescription.bottomAnchor, constant: 16.0),
            weightDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            typesDescription.topAnchor.constraint(equalTo: weightDescription.bottomAnchor, constant: 16.0),
            typesDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        ])
    }
    
    func additionalSetup() {
        backgroundColor = .white
        configure()
    }
}

