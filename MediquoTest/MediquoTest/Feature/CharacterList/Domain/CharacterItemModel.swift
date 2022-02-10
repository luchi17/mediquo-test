//
//  CharacterItemModel.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 21/01/22.
//

import Foundation
import RealmSwift

class CharacterItemModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var compoundKey = ""
    @objc dynamic var name: String = ""
    @objc dynamic var age: String?
    @objc dynamic var nickname: String = ""
    @objc dynamic var series: String = ""
    @objc dynamic var seasons: String = ""
    @objc dynamic var quotes: String? = ""
    @objc dynamic var imageData: Data? = Data()
    
    var image: UIImage? {
        if let imageData = imageData {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func setUpPrimaryKey(id: Int, series: String) {
        self.id = id
        self.series = series
        self.compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(id)\(series)"
    }
}

