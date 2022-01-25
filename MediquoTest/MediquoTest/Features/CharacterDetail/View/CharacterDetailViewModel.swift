//
//  CharacterDetailViewModel.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 25/1/22.
//

import Foundation

class CharacterDetailViewModel: NSObject {
    
    private var characterDetailManager: CharacterDetailManagerProtocol
    
    var quotes: ObservableObject<String> = ObservableObject()
    
    init(characterDetailManager: CharacterDetailManagerProtocol) {
        self.characterDetailManager = characterDetailManager
    }
}

extension CharacterDetailViewModel: CharacterDetailInterfaceToViewModelProtocol {
   
    func loadCharacterQuotes(characterItem: CharacterItemModel) {
        characterDetailManager.getCharacterQuotesData(characterItem: characterItem) { response in
            self.quotes.value = response
        }
    }
}


protocol CharacterDetailInterfaceToViewModelProtocol {
    func loadCharacterQuotes(characterItem: CharacterItemModel)
    var quotes: ObservableObject<String>{ get set }
}
