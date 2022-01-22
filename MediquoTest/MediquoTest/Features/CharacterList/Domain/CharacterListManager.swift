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

            self.getCharacters(by: Series.breakingBad.rawValue) { breakingBadCharactersDataOut in
                
                var breakingBadCharacters: [CharacterItemModel] = []
                var betterCallSaulCharacters: [CharacterItemModel] = []
                
                for character in breakingBadCharactersDataOut {
                    breakingBadCharacters.append(character)
                }
                for character in betterCallSaulCharactersDataOut {
                    betterCallSaulCharacters.append(character)
                }
                
                charactersListModel.breakingBadCharacters = breakingBadCharacters
                charactersListModel.betterCallSaulCharacters = betterCallSaulCharacters
                
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
                                                           image: Utils.getImage(from: itemDataOut.img),
                                                           age: Utils.getAgeFromBirthDate(dateString: itemDataOut.birthday),
                                                           nickname: itemDataOut.nickname,
                                                           series: Series.betterCallSaul.rawValue,
                                                           seasons: self.setUpSeasons(seasons: itemDataOut.appearance))
                   
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
    
    private func setUpSeasons(seasons: [Int]) -> String {
        var seasonsString: String = ""
        for season in seasons {
            seasonsString = "Season: " + String(season) + "\n"
        }
        return seasonsString
    }
}

protocol CharacterListManagerProtocol {
    func getCharacterListData(onSuccess: @escaping (CharacterListModel) -> (), onError: @escaping (Error?) -> ())
}

enum Series: String {
    case breakingBad = "Better Call Saul"
    case betterCallSaul = "Breaking Bad"
}
