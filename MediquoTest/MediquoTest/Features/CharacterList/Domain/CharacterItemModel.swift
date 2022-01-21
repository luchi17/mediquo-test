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
        return lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.imageUrlString == rhs.imageUrlString
    }
    
    var title: String
    var description: String
    var imageUrlString: String
    
}
