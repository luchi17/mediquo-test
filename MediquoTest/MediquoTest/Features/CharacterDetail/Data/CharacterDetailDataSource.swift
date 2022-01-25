//
//  CharacterDetailDataSource.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import Foundation

class CharacterDetailDataSource : NSObject, CharacterDetailDataSourceProtocol {
    
    var networkManager: NetworkManager = NetworkManager()
    
    func getCharacterQuotesData(name: String, onSuccess: @escaping ([QuoteDataOut]?) -> (), onError: @escaping (Error?) -> ()) {
        
        let queryParams = ["author": name]
        networkManager.doJSONRequest(endpointKey: EndpointRepositoryKeys.charactersQuotes.rawValue,
                                     queryParams: queryParams,
                                     onSuccess: onSuccess,
                                     onError: onError)
    }
}

protocol CharacterDetailDataSourceProtocol {
    
    func getCharacterQuotesData(name: String, onSuccess: @escaping ([QuoteDataOut]?) -> (), onError: @escaping (Error?) -> ())
    
}
