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
        setupHierarchy()
        setupConstraints()
        additionalSetup()
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
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
        let types = pokemonInfo.types.map({
            $0.type
                .name
            .capitalized })
            .joined(separator: ", ")
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
        
        nameStackView.addArrangedSubview(idLabel)
        nameStackView.addArrangedSubview(nameLabel)
        
        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(nameStackView)
        containerStackView.addSpacing(18)
        containerStackView.addArrangedSubview(heightDescription)
        containerStackView.addSpacing(9)
        containerStackView.addArrangedSubview(weightDescription)
        containerStackView.addSpacing(18)
        containerStackView.addArrangedSubview(typesDescription)
        containerStackView.addSpacing(18)
        
        scrollView.addSubview(containerStackView)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        NSLayoutConstraint.activate([
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func additionalSetup() {
        backgroundColor = .systemGray4
        configure()
    }
}

