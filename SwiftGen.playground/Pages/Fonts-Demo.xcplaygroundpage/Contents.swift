//: #### Other pages
//:
//: * [Demo for `colors` parser](Colors-Demo)
//: * [Demo for `coredata` parser](CoreData-Demo)
//: * Demo for `fonts` parser
//: * [Demo for `files` parser](Files-Demo)
//: * [Demo for `ib` parser](InterfaceBuilder-Demo)
//: * [Demo for `json` parser](JSON-Demo)
//: * [Demo for `plist` parser](Plist-Demo)
//: * [Demo for `strings` parser](Strings-Demo)
//: * [Demo for `xcassets` parser](XCAssets-Demo)
//: * [Demo for `yaml` parser](YAML-Demo)

//: #### Example of code generated by `fonts` parser with "swift5" template

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
enum FontFamily {
  enum Avenir {
    static let black = FontConvertible(name: "Avenir-Black", family: "Avenir", path: "Avenir.ttc")
    static let blackOblique = FontConvertible(name: "Avenir-BlackOblique", family: "Avenir", path: "Avenir.ttc")
    static let book = FontConvertible(name: "Avenir-Book", family: "Avenir", path: "Avenir.ttc")
    static let bookOblique = FontConvertible(name: "Avenir-BookOblique", family: "Avenir", path: "Avenir.ttc")
    static let heavy = FontConvertible(name: "Avenir-Heavy", family: "Avenir", path: "Avenir.ttc")
    static let heavyOblique = FontConvertible(name: "Avenir-HeavyOblique", family: "Avenir", path: "Avenir.ttc")
    static let light = FontConvertible(name: "Avenir-Light", family: "Avenir", path: "Avenir.ttc")
    static let lightOblique = FontConvertible(name: "Avenir-LightOblique", family: "Avenir", path: "Avenir.ttc")
    static let medium = FontConvertible(name: "Avenir-Medium", family: "Avenir", path: "Avenir.ttc")
    static let mediumOblique = FontConvertible(name: "Avenir-MediumOblique", family: "Avenir", path: "Avenir.ttc")
    static let oblique = FontConvertible(name: "Avenir-Oblique", family: "Avenir", path: "Avenir.ttc")
    static let roman = FontConvertible(name: "Avenir-Roman", family: "Avenir", path: "Avenir.ttc")
    static let all: [FontConvertible] = [black, blackOblique, book, bookOblique, heavy, heavyOblique, light, lightOblique, medium, mediumOblique, oblique, roman]
  }
  enum ZapfDingbats {
    static let regular = FontConvertible(name: "ZapfDingbatsITC", family: "Zapf Dingbats", path: "ZapfDingbats.ttf")
    static let all: [FontConvertible] = [regular]
  }
  static let allCustomFonts: [FontConvertible] = [Avenir.all, ZapfDingbats.all].flatMap { $0 }
  static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

//: #### Usage Example
// Using the UIFont constructor…
let body = UIFont(font: FontFamily.Avenir.light, size: 20.0)
// Or using the enum value and its `font` method
let title = FontFamily.ZapfDingbats.regular.font(size: 20.0)

let bodyHuge = FontFamily.Avenir.black.font(size: 100.0)
let titleTiny = UIFont(font: FontFamily.ZapfDingbats.regular, size: 8.0)
