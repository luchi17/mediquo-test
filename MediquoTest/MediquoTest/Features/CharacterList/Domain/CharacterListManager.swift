//
//  CharacterListManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import UIKit

class CharacterListManager: NSObject, CharacterListManagerProtocol {
    
    private var dataSource: CharacterListDataSourceProtocol
    init(dataSource: CharacterListDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getCharacterListData(onSuccess: @escaping (CharacterListModel) -> (), onError: @escaping (Error?) -> ()) {
        
        var charactersListModel = CharacterListModel()
        
        self.getCharacters(by: Series.betterCallSaul.rawValue) { betterCallSaulCharactersDataOut in
            
            var betterCallSaulCharacters: [CharacterItemModel] = []
            
            for character in betterCallSaulCharactersDataOut {
                betterCallSaulCharacters.append(character)
            }
            
            charactersListModel.betterCallSaulCharacters = betterCallSaulCharacters
            
            self.getCharacters(by: Series.breakingBad.rawValue) { breakingBadCharactersDataOut in
                
                var breakingBadCharacters: [CharacterItemModel] = []
                
                for character in breakingBadCharactersDataOut {
                    breakingBadCharacters.append(character)
                }
                
                charactersListModel.breakingBadCharacters = breakingBadCharacters
                
                onSuccess(charactersListModel)
                
            } onError: { error in
                onError(nil)
            }
            
        } onError: { error in
            onError(error)
        }
    }
    
    private func getCharacters(by series: String, onSuccess: @escaping ([CharacterItemModel]) -> (), onError: @escaping (Error?) -> ()) {
        
        self.dataSource.getCharactersListBySeries(name: series) { itemsList in
            
            if let itemsList = itemsList {
                
                var characterItems: [CharacterItemModel] = []
            
                for itemDataOut in itemsList {
                    let characterItem = CharacterItemModel(id: itemDataOut.char_id,
                                                           name: itemDataOut.name,
                                                           image: itemDataOut.img,
                                                           nickname: itemDataOut.nickname,
                                                           series: Series.betterCallSaul.rawValue,
                                                           seasons: itemDataOut.appearance)
                    
                    characterItems.append(characterItem)
                }
            
                onSuccess(characterItems)
                
            } else {
                onError(nil)
            }
            
        } onError: { error in
            onError(error)
        }

    }
}

protocol CharacterListManagerProtocol {
    func getCharacterListData(onSuccess: @escaping (CharacterListModel) -> (), onError: @escaping (Error?) -> ())
}

enum Series: String {
    case breakingBad = "Better Call Saul"
    case betterCallSaul = "Breaking Bad"
}
