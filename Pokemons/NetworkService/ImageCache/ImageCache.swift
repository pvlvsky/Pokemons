//
//  ImageCache.swift
//  Pokemons
//
//  Created by Ярослав Павловский on 29.03.23.
//

import UIKit

final class ImageCache: ImageCacheProtocol {
        
    private static let cache = NSCache<NSString, UIImage>()
    
    private static var responses = [URL: [(UIImage?) -> ()]]()
        
    static func getImage(with url: URL, completion: @escaping (UIImage?) -> ()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            loadImage(with: url, completion: completion)
        }
    }
    
    static func loadImage(with url: URL, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if responses[url] != nil {
                responses[url]?.append(completion)
                return
            } else {
                responses[url] = [completion]
            }

            guard let data = data,
                  let image = UIImage(data: data),
                  let blocks = self.responses[url] else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            cache.setObject(image, forKey: url.absoluteString as NSString)
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
            }
        }.resume()
    }
}
