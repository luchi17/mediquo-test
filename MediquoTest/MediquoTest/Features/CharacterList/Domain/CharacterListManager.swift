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
        self.dataSource.getCharacterListData { itemsList in
            if let itemsList = itemsList, let itemsDataOut = itemsList.items {
                
                var characterItems: [CharacterItemModel] = []
            
                for itemDataOut in itemsDataOut {
                    let characterItem = CharacterItemModel(title: itemDataOut.title,
                                                 description: itemDataOut.desc,
                                                 imageUrlString: itemDataOut.image)
                    characterItems.append(characterItem)
                }
                
                let characterListModel = CharacterListModel(items: characterItems)
                onSuccess(characterListModel)
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
