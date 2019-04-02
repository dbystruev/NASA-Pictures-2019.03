//
//  Networking.swift
//  NASA Pictures
//
//  Created by Denis Bystruev on 02/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class Networking {
    
    static let shared = Networking()
    
    private init() { }
    
    let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    let query = [
        "api_key": "DEMO_KEY",
        "date": "2019-04-02"
    ]
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        
        let url = baseURL.withQueries(query)!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    print(#function, #line, error.localizedDescription)
                }
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) else {
                print(Date(), #function, #line, "Can't decode \(data)")
                completion(nil)
                return
            }

            completion(photoInfo)
            
        }.resume()
    }
    
    func fetchImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
