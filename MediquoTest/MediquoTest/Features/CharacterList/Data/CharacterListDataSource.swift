//
//  CharacterListDataSource.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import Foundation

class CharacterListDataSource : NSObject, CharacterListDataSourceProtocol {
    
    var networkManager: NetworkManager = NetworkManager()
    
    func getCharactersListData(onSuccess: @escaping ([CharacterItemDataOut]?) -> (), onError: @escaping (Error?) -> ()) {
        
        networkManager.doJSONRequest(endpointKey: EndpointRepositoryKeys.charactersList.rawValue,
                                     onSuccess: onSuccess,
                                     onError: onError)
    }
    
    func getCharactersListBySeries(name: String, onSuccess: @escaping ([CharacterItemDataOut]?) -> (), onError: @escaping (Error?) -> ()) {
        
        let queryParams = ["category": name]
        networkManager.doJSONRequest(endpointKey: EndpointRepositoryKeys.charactersList.rawValue,
                                     queryParams: queryParams,
                                     onSuccess: onSuccess,
                                     onError: onError)
    }
    
}

protocol CharacterListDataSourceProtocol {
    
    func getCharactersListData(onSuccess: @escaping ([CharacterItemDataOut]?) -> (), onError: @escaping (Error?) -> ())
    func getCharactersListBySeries(name: String, onSuccess: @escaping ([CharacterItemDataOut]?) -> (), onError: @escaping (Error?) -> ())
    
}
