//
// SwiftGenKit
// Copyright © 2020 SwiftGen
// MIT Licence
//

import Foundation
import PathKit

extension Strings {
  final class StringsFileParser: StringsFileTypeParser {
    private let options: ParserOptionValues

    init(options: ParserOptionValues) {
      self.options = options
    }

    static let extensions = ["strings"]

    // Localizable.strings files are generally UTF16, not UTF8!
    func parseFile(at path: Path) throws -> [Strings.Entry] {
      guard let data = try? path.read() else {
        throw ParserError.failureOnLoading(path: path)
      }

      let entries = try PropertyListDecoder()
        .decode([String: String].self, from: data)
        .map { key, translation -> (String, Entry) in
          let entry = try Entry(key: key, translation: translation, keyStructureSeparator: options[Option.separator])
          return (key, entry)
        }

      var dict = Dictionary(uniqueKeysWithValues: entries)

      if let string: String = try? path.read() {
        let scanner = Scanner(string: string)
        while !scanner.isAtEnd {
          let comment = scanner.scanComment()
          if let key = scanner.scanQuotedString() {
            dict[key]?.comment = comment

            // Scan in the value and ignore it.
            scanner.scanUpTo(.quote, into: nil)
            _ = scanner.scanQuotedString()
          }
        }
      }

      return Array(dict.values)
    }
  }
}

private extension String {
  static var startComment: String { "/*" }
  static var endComment: String { "*/" }
  static var quote: String { "\"" }
}

private extension Scanner {
  func scanComment() -> String? {
    scanUpTo(.startComment, into: nil)

    var optionalComment: NSString?

    guard scanString(.startComment, into: nil),
      scanUpTo(.endComment, into: &optionalComment),
      let comment = optionalComment else {
      return nil
    }

    scanString(.endComment, into: nil)
    return comment.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func scanQuotedString() -> String? {
    guard scanString(.quote, into: nil) else {
      return nil
    }

    var key = ""

    let startingCharactersToBeSkipped = charactersToBeSkipped
    charactersToBeSkipped = nil
    defer { charactersToBeSkipped = startingCharactersToBeSkipped }

    while let character = scanCharacter(),
      character != "\"" {
      if character == "\\",
        let escapedCharacter = scanEscapedCharacter() {
        key.append(escapedCharacter)
      } else {
        key.append(character)
      }
    }

    scanString(.quote, into: nil)
    return key
  }

  func scanCharacter() -> Character? {
    guard let index = string.index(string.startIndex, offsetBy: scanLocation, limitedBy: string.endIndex) else {
      return nil
    }

    defer { scanLocation += 1 }
    return string[index]
  }

  /// Loosely based on
  /// https://opensource.apple.com/source/CF/CF-550/CFPropertyList.c.auto.html
  func scanEscapedCharacter() -> Character? {
    let character = scanCharacter()

    switch character {
    case "n":
      return "\n"
    case "t":
      return "\t"
    case "\"":
      return "\""
    default:
      return character
    }
  }
}
