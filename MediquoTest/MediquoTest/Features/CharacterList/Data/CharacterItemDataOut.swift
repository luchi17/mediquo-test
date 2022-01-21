//
//  CharacterItemDataOut.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation


struct CharacterItemDataOut: Decodable {
    var char_id: Int
    var name: String
    var birthday: String
    var occupation: [String]
    var img: String
    var status: String
    var nickname: String
    var appearance: [Int]
    var portrayed: String
}
