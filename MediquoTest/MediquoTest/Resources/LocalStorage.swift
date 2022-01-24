//
//  LocalStorage.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 24/1/22.
//

import Foundation

class LocalStorage {
    
    static let userDefaults = UserDefaults()
    
    private enum Keys: String {
        case language
    }
    
    static func registerDefaultLanguage() {
        userDefaults.register(defaults: [
            Keys.language.rawValue: getDefaultAppLanguage().rawValue
        ])
    }

    // MARK: - Keys for language
    static var language: AppLanguage {
        get {
            if let languageCode = userDefaults.value(forKey: Keys.language.rawValue) as? String {
                return getDefaultAppLanguage(from: languageCode)
            }
            return getDefaultAppLanguage()
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.language.rawValue)
        }
    }
    
    // MARK: - Helper methods
    
    private static func getDefaultAppLanguage(from languageCode: String? = nil) -> AppLanguage {

        if let language = languageCode {
            return AppLanguage(rawValue: language) ?? .castellano
        } else {
            return .castellano
        }
    }
}
