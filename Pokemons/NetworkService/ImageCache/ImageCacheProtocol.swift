//
//  ImageCacheProtocol.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

protocol ImageCacheProtocol {
    static func getImage(with url: URL, completion: @escaping (UIImage?) -> ())
    static func loadImage(with url: URL, completion: @escaping (UIImage?) -> ())
}
