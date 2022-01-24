//
//  AppLanguage.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 24/1/22.
//

import Foundation

public enum AppLanguage: String {
    case castellano = "es"
    case catala = "ca-ES"
    case euskera = "eu-ES"
    case galego = "gl-ES"
    
    static func createByServiceString(langService: String) -> AppLanguage {
        
        switch langService.uppercased() {
        case "ES":
            return .castellano
        case "CA":
            return .catala
        case "EU":
            return .euskera
        case "GL":
            return .galego
        default:
            return .castellano
        }
    }
    
    static func getStringByNumber(number: String) -> String {
        switch number {
        case "01":
            return "ES"
        case "02":
            return "CA"
        case "03":
            return "EU"
        default:
            return "ES"
        }
    }
}
