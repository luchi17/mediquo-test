//
//  CharacterListManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 28/11/21.
//

import UIKit
import RealmSwift

class CharacterListManager: NSObject, CharacterListManagerProtocol {
    
    private var dataSource: CharacterListDataSourceProtocol
    
    init(dataSource: CharacterListDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getCharacterListData(onSuccess: @escaping (CharacterListModel) -> (), onError: @escaping (Error?) -> ()) {
        
        var charactersListModel = CharacterListModel()
        
        self.getCharacters(by: Series.betterCallSaul.rawValue) { betterCallSaulCharacters in
            
            self.getCharacters(by: Series.breakingBad.rawValue) { breakingBadCharacters in
                
                charactersListModel.breakingBadCharacters = breakingBadCharacters
                charactersListModel.betterCallSaulCharacters = betterCallSaulCharacters

                onSuccess(charactersListModel)
                return
                
            } onError: { error in
                onError(nil)
            }
            
        } onError: { error in
            onError(error)
        }
    }
    
    private func getCharacters(by series: String, onSuccess: @escaping ([CharacterItemModel]) -> (), onError: @escaping (Error?) -> ()) {
        
        var predicate: (CharacterItemModel) throws -> Bool
        predicate = { item in
            item.series == series
        }
        
        let characters = RealmManager.shared.read(fromEntity: CharacterItemModel.self, predicate: predicate)
        
        if !characters.isEmpty {
            onSuccess(characters)
            return
        }
       
        self.dataSource.getCharactersListBySeries(name: series) { itemsList in
            
            if let itemsList = itemsList {
                
                var characterItems: [CharacterItemModel] = []
            
                for itemDataOut in itemsList {
                    
                    let characterItem = CharacterItemModel()
                    characterItem.setUpPrimaryKey(id: itemDataOut.char_id,
                                                  series: series)
                    characterItem.name = itemDataOut.name
                    characterItem.imageData = Utils.getImageData(from: itemDataOut.img)
                    characterItem.age = Utils.getAgeFromBirthDate(dateString: itemDataOut.birthday)
                    characterItem.nickname = itemDataOut.nickname
                    characterItem.seasons = self.setUpSeasons(seasons: itemDataOut.appearance)
                   
                    characterItems.append(characterItem)
                }
                
                RealmManager.shared.add(characterItems)
                onSuccess(characterItems)
                return
                
            } else {
                onError(nil)
                return
            }
            
        } onError: { error in
            onError(error)
            return
        }
    }
    
    private func setUpSeasons(seasons: [Int]) -> String {
        var seasonsString: String = ""
        for season in seasons {
            
            seasonsString = seasonsString + Localization.CharacterDetail.season + String(season) + "\n"
        }
        return seasonsString
    }
}

protocol CharacterListManagerProtocol {
    func getCharacterListData(onSuccess: @escaping (CharacterListModel) -> (), onError: @escaping (Error?) -> ())
}

enum Series: String {
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
}
