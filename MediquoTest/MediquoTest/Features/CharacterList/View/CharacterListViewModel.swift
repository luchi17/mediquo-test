//
//  CharacterListViewModel.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation

class CharacterListViewModel: NSObject {
    
    private var characterListManager: CharacterListManagerProtocol
    
    var characterListModel: ObservableObject<CharacterListModel> = ObservableObject()
    var error: ObservableObject<Error> = ObservableObject()
    
    init(characterListManager: CharacterListManagerProtocol) {
        self.characterListManager = characterListManager
        
    }
}

extension CharacterListViewModel: CharacterListInterfaceToViewModelProtocol {
   
    func loadCharacterList() {
        
        characterListManager.getCharacterListData { response in
            self.characterListModel.value = response
        } onError: { error in
            if let error = error {
                self.error.value = error
            }
        }
    }
}


protocol CharacterListInterfaceToViewModelProtocol {
    func loadCharacterList()
    var error: ObservableObject<Error>{ get set }
    var characterListModel: ObservableObject<CharacterListModel>{ get set }
}
