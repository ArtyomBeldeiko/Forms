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
    static let postRequestUrl = "http://test.clevertec.ru/tt/data/"
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
    
    func downloadImage(with urlString: String, imageCompletionHandler: @escaping (UIImage?) -> Void){
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
    
    func sendFieldData(textualField: String, numericalField: String, listValue: String, completion: @escaping (Result<Response, Error>) -> Void) {
        guard let url = URL(string: "\(NetworkManagerConstants.postRequestUrl)") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let form: [String : Any] = ["form" : ["text" : textualField, "numeric" : numericalField, "list" : listValue]]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: form)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
