//
//  CharacterListManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import UIKit
import CloudKit

class CharacterDetailManager: NSObject, CharacterDetailManagerProtocol {
    
    private var dataSource: CharacterDetailDataSourceProtocol
    init(dataSource: CharacterDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getCharacterQuotesData(characterItem: CharacterItemModel, onSuccess: @escaping (CharacterItemModel) -> (), onError: @escaping (Error?) -> ()) {
        
        self.dataSource.getCharacterQuotesData(name: characterItem.name) { quotesDataOut in
            
            if let quotesDataOut = quotesDataOut  {
                
                var quotes: String = ""
                for quoteDataOut in quotesDataOut {
                    quotes = quotes + quoteDataOut.quote + "\n"
                }
                characterItem.quotes = quotes
                onSuccess(characterItem)
                
            }
            
        } onError: { error in
            onError(error)
        }
    }
}

protocol CharacterDetailManagerProtocol {
    func getCharacterQuotesData(characterItem: CharacterItemModel, onSuccess: @escaping (CharacterItemModel) -> (), onError: @escaping (Error?) -> ())
}
