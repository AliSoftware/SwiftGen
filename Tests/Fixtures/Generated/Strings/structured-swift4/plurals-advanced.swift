// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Multiple {
    internal enum Placeholders {
      /// Plural case 'other': %@ has %d ratings
      internal static func stringInt(_ p1: Int) -> String {
        return L10n.tr("LocPluralAdvanced", "multiple.placeholders.string-int", p1)
      }
    }
    internal enum Variables {
      /// Plural case 'other': %d files remaining (%d bytes, %d minutes)
      internal static func threeVariablesInFormatkey(_ p1: Int, _ p2: Int, _ p3: Int) -> String {
        return L10n.tr("LocPluralAdvanced", "multiple.variables.three-variables-in-formatkey", p1, p2, p3)
      }
    }
  }

  internal enum Nested {
    /// Plural case 'other': %1$#@geese@
    internal static func formatkeyInVariable(_ p1: Int, _ p2: Int, _ p3: Int) -> String {
      return L10n.tr("LocPluralAdvanced", "nested.formatkey-in-variable", p1, p2, p3)
    }
    /// Plural case 'other': %1$#@first_level@
    internal static func formatkeyInVariableDeep(_ p1: Int, _ p2: Int, _ p3: Int) -> String {
      return L10n.tr("LocPluralAdvanced", "nested.formatkey-in-variable-deep", p1, p2, p3)
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: BundleToken.bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type