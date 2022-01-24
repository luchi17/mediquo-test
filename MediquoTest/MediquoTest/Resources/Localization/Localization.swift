// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings




// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name

 internal enum Localization {
  internal enum CharacterDetail {
    /// Edad
    internal static var age: String { return Localization.tr("Localizable","characterDetail.age") }
    /// Desconocida
    internal static var ageUnknown: String { return Localization.tr("Localizable","characterDetail.ageUnknown") }
    /// Nombre
    internal static var name: String { return Localization.tr("Localizable","characterDetail.name") }
    /// Apodo
    internal static var nick: String { return Localization.tr("Localizable","characterDetail.nick") }
    /// Sus frases conocidas
    internal static var quotes: String { return Localization.tr("Localizable","characterDetail.quotes") }
    /// Temporada 
    internal static var season: String { return Localization.tr("Localizable","characterDetail.season") }
    /// Temporadas en las que aparece
    internal static var seasons: String { return Localization.tr("Localizable","characterDetail.seasons") }
  }
  internal enum Language {
    /// English
    internal static var english: String { return Localization.tr("Localizable","language.english") }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let bundle: Bundle
    let lang = LocalStorage.language.rawValue
    if let path = Bundle.main.path(forResource: lang, ofType: "lproj"), let langBundle = Bundle(path: path) {
      bundle = langBundle
    } else {
      bundle = Bundle(for: BundleToken.self)
    }
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
