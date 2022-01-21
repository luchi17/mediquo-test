//
//  CharacterItemModel.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation
import UIKit

struct CharacterItemModel: Equatable, Hashable {
    
    static func == (lhs: CharacterItemModel, rhs: CharacterItemModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var image: String
    var nickname: String
}
