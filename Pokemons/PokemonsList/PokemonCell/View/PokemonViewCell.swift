//
//  PokemonViewCell.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

final class PokemonViewCell: UICollectionViewCell {
    
    var imageCache = ImageCache()
    
    lazy var nameLabel = setupNameLabel()
    lazy var imageView = setupImage()
    lazy var idLabel = setupIdLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 14
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.idLabel.text = nil
        self.nameLabel.text = nil
    }
    
    func setImage(id: String) {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") else { return }
        imageCache.getImage(with: url) { [weak self] (image) in
            guard let image = image,
                  let self = self else { return }
            self.imageView.image = image
        }
    }
}
