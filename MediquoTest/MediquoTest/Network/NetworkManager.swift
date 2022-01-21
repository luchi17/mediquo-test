//
//  NetworkManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/1/22.
//

import Foundation

class NetworkManager {
    
    private let baseURLString = "https://www.breakingbadapi.com/api"
    
    init() { }
    
    func doJSONRequest<T: Decodable>(endpointKey: String, queryParams : [String: String]? = nil, onSuccess: @escaping (T?) -> Void, onError: @escaping (Error?) -> Void) {
        
        let urlString = self.setupRequestUrlString(endpointKey: endpointKey, queryParams: queryParams)
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil || data == nil {
                onError(error)
                
            } else {
                if let data = data {

                    let jsonDecoder = JSONDecoder()

                    let dataDecoded = try? jsonDecoder.decode(T.self, from: data)
                    onSuccess(dataDecoded)
                }
            }
        }.resume()
    }
    
    private func setupRequestUrlString(endpointKey: String, queryParams : [String: String]? = nil) -> String {
        return baseURLString + endpointKey
    }
}
