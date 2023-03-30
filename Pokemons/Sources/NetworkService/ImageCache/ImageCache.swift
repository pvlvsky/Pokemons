//
//  ImageCache.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

final class ImageCache: ImageCacheProtocol {
        
    static let cache = NSCache<NSString, UIImage>()
    
    static var responses = [URL: [(UIImage?) -> ()]]()
    
    //MARK: Проверка на наличие картинки в кэше, если ее нет то загружаем картинку и добавляем ее в кэш
    
    static func getImage(with url: URL, completion: @escaping (UIImage?) -> ()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            loadImage(with: url, completion: completion)
        }
    }
    
    static func loadImage(with url: URL, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if self.responses[url] != nil {
                self.responses[url]?.append(completion)
                return
            } else {
                self.responses[url] = [completion]
            }

            guard let data = data,
                  let image = UIImage(data: data),
                  let blocks = self.responses[url] else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
            }
        }.resume()
    }
}
