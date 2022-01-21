//
//  CharacterListViewModel.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation

class CharacterListViewModel: NSObject {
    
    private var characterListManager: CharacterListManagerProtocol
    private var characterListModel: CharacterListModel? {
        didSet {
            self.bindCharacterListModel(characterListModel)
        }
    }
    
    var bindCharacterListModel : ((CharacterListModel?) -> ()) = { response in }
    
    init(characterListManager: CharacterListManagerProtocol) {
        self.characterListManager = characterListManager
    }
}

extension CharacterListViewModel: CharacterListInterfaceToViewModelProtocol {
    
    func loadCharacterList() {
        characterListManager.getCharacterListData { characterListModel in
            self.characterListModel = characterListModel
        } onError: { error in
            
        }

    }
}


protocol CharacterListInterfaceToViewModelProtocol {
    func loadCharacterList()
    var bindCharacterListModel: ((CharacterListModel?) -> ()) { get set }
}
