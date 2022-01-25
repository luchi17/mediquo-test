//
//  CharacterListManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import UIKit
import CloudKit
import RealmSwift

class CharacterDetailManager: NSObject, CharacterDetailManagerProtocol {
    
    private var dataSource: CharacterDetailDataSourceProtocol
    init(dataSource: CharacterDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getCharacterQuotesData(characterItem: CharacterItemModel, onSuccess: @escaping (String) -> ()) {
        
        var predicate: (CharacterItemModel) throws -> Bool
        predicate = { item in
            item == characterItem
        }

        if let characterItem = RealmManager.shared.read(fromEntity: CharacterItemModel.self, predicate: predicate).first,
           let quotes = characterItem.quotes, !quotes.isEmpty {
            onSuccess(quotes)
            return
        }
        
        self.dataSource.getCharacterQuotesData(name: characterItem.name) { quotesDataOut in
            
            if let quotesDataOut = quotesDataOut  {
                
                let quotes: String = self.setUpQuotes(quotesDataOut: quotesDataOut)
                
                RealmManager.shared.update(characterItem) { item in
                    item.quotes = quotes
                }
                
                onSuccess(quotes)
                return
            }
            
        } onError: { error in
            onSuccess("")
        }
    }
    
    private func setUpQuotes(quotesDataOut: [QuoteDataOut]) -> String {
        
        var quotes: String = ""
        
        for (index, quoteDataOut) in quotesDataOut.enumerated() {
            quotes = quotes + " \(index)_ "  + quoteDataOut.quote + "\n\n"
        }
        return quotes
    }
}

protocol CharacterDetailManagerProtocol {
    func getCharacterQuotesData(characterItem: CharacterItemModel, onSuccess: @escaping (String) -> ())
}
