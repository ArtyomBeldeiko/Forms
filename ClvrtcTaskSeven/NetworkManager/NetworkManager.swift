//
//  NetworkManager.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 26.01.23.
//

import Foundation
import Kingfisher

struct NetworkManagerConstants {
    static let getRequestUrl = "http://test.clevertec.ru/tt/meta/"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getForm(completion: @escaping (Result<Form, Error>) -> Void) {
        guard let url = URL(string: "\(NetworkManagerConstants.getRequestUrl)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Form.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(with urlString : String, imageCompletionHandler: @escaping (UIImage?) -> Void){
        guard let url = URL.init(string: urlString) else { return  imageCompletionHandler(nil) }
        
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(nil)
            }
        }
    }
}
