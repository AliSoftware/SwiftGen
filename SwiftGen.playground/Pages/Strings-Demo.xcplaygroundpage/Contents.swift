//: #### Other pages
//:
//: * [Demo for `colors` parser](Colors-Demo)
//: * [Demo for `coredata` parser](CoreData-Demo)
//: * [Demo for `files` parser](Files-Demo)
//: * [Demo for `fonts` parser](Fonts-Demo)
//: * [Demo for `ib` parser](InterfaceBuilder-Demo)
//: * [Demo for `json` parser](JSON-Demo)
//: * [Demo for `plist` parser](Plist-Demo)
//: * Demo for `strings` parser
//: * [Demo for `xcassets` parser](XCAssets-Demo)
//: * [Demo for `yaml` parser](YAML-Demo)

//: #### Example of code generated by `strings` parser with "structured-swift5" template

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
enum L10n {
  /// Some alert body there
  internal static let alertMessage = L10n.tr("Localizable", "alert_message")
  /// Title of the alert
  internal static let alertTitle = L10n.tr("Localizable", "alert_title")
  /// These are %3$@'s %1$d %2$@.
  internal static func objectOwnership(_ p1: Int, _ p2: String, _ p3: String) -> String {
    return L10n.tr("Localizable", "ObjectOwnership", p1, p2, p3)
  }
  /// Hello, my name is %@ and I'm %d
  internal static func `private`(_ p1: String, _ p2: Int) -> String {
    return L10n.tr("Localizable", "private", p1, p2)
  }

  enum Apples {
    /// You have %d apples
    internal static func count(_ p1: Int) -> String {
      return L10n.tr("Localizable", "apples.count", p1)
    }
  }

  enum Bananas {
    /// Those %d bananas belong to %@.
    internal static func owner(_ p1: Int, _ p2: String) -> String {
      return L10n.tr("Localizable", "bananas.owner", p1, p2)
    }
  }

  enum Settings {
    enum UserProfileSection {
      /// Here you can change some user profile settings.
      internal static let footerText = L10n.tr("Localizable", "settings.user_profile_section.footer_text")
      /// User Profile Settings
      internal static let headerTitle = L10n.tr("Localizable", "settings.user_profile_section.HEADER_TITLE")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

//: #### Usage example

let alertTitle = L10n.alertTitle
let hello1 = L10n.private("David", 29)
let hello2 = L10n.private("Olivier", 32) // Prints as a string in the console because it's CustomStringConvertible

// note the inversion of parameters' order due to usage of %1$d, %2$@ and %1$@ in Localizable.strings
L10n.objectOwnership(3, "Apples", "John")
