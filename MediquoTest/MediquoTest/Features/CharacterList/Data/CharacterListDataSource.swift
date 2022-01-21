//
//  CharacterListDataSource.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import Foundation

class CharacterListDataSource : NSObject, CharacterListDataSourceProtocol {
    
    var networkManager: NetworkManager = NetworkManager()
    
    func getCharacterListData(onSuccess: @escaping (CharacterListDataOut?) -> (), onError: @escaping (Error?) -> ()) {
        
        networkManager.doJSONRequest(endpointKey: EndpointRepositoryKeys.charactersList.rawValue,
                                     onSuccess: onSuccess,
                                     onError: onError)
    }
    
    func getCharacterByNameData(name: String, onSuccess: @escaping (CharacterListDataOut?) -> (), onError: @escaping (Error?) -> ()) {
        
    }
}

protocol CharacterListDataSourceProtocol {
    func getCharacterListData(onSuccess: @escaping (CharacterListDataOut?) -> (), onError: @escaping (Error?) -> ())
    func getCharacterByNameData(name: String, onSuccess: @escaping (CharacterListDataOut?) -> (), onError: @escaping (Error?) -> ())
}
