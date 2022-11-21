//
//  NetworkManager.swift
//  RandomQuotesServiceCall
//
//  Created by Hasan Esat Tozlu on 20.11.2022.
//

import Foundation

class NetworkManager {
    
    enum Endpoints {
        static let base = "https://programming-quotes-api.herokuapp.com/Quotes"

        case random

        var stringValue: String {
            switch self {
            case .random:
                return Endpoints.base + "/random"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
            }
        }
        task.resume()
        return task
    }
    
    class func getRandomQuotes(completion: @escaping (RandomModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.random.url, responseType: RandomModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
