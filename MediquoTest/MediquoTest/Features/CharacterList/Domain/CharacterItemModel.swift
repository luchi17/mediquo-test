//
//  CharacterItemModel.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation
import UIKit

class CharacterItemModel: Equatable {
    
    var id: Int
    var name: String
    var image: UIImage?
    var age: String?
    var nickname: String
    var series: String
    var seasons: String
    var quotes: String?
    
    init(id: Int, name: String, image: UIImage? = nil, age: String? = nil, nickname: String, series: String, seasons: String, quotes: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.age = age
        self.nickname = nickname
        self.series = series
        self.seasons = seasons
        self.quotes = quotes
    }
    
    static func == (lhs: CharacterItemModel, rhs: CharacterItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
