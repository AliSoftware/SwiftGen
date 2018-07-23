//
//  Attribute.swift
//  SwiftGenKit
//
//  Created by Grant Butler on 7/19/18.
//  Copyright © 2018 AliSoftware. All rights reserved.
//

import Foundation
import Kanna

extension CoreData {
  public struct Attribute {
    public let name: String
    public let isIndexed: Bool
    public let isOptional: Bool
    public let isTransient: Bool
    public let usesScalarValueType: Bool

    public let type: AttributeType
    public let customClassName: String?
    public let typeName: String
  }

  public enum AttributeType: String {
    case integer16     = "Integer 16"
    case integer32     = "Integer 32"
    case integer64     = "Integer 64"
    case decimal       = "Decimal"
    case double        = "Double"
    case float         = "Float"
    case string        = "String"
    case boolean       = "Boolean"
    case date          = "Date"
    case binaryData    = "Binary"
    case transformable = "Transformable"
    case URI           = "URI"
    case UUID          = "UUID"
  }
}

private enum XML {
  fileprivate enum Attributes {
    static let name = "name"
    static let isIndexed = "indexed"
    static let isOptional = "optional"
    static let isTransient = "transient"
    static let usesScalarValueType = "usesScalarValueType"

    static let attributeType = "attributeType"
    static let customClassName = "customClassName"
  }
}

extension CoreData.Attribute {
  init(with object: Kanna.XMLElement) throws {
    name = object[XML.Attributes.name] ?? ""
    isIndexed = object[XML.Attributes.isIndexed].flatMap(Bool.init(from:)) ?? false
    isOptional = object[XML.Attributes.isOptional].flatMap(Bool.init(from:)) ?? false
    isTransient = object[XML.Attributes.isTransient].flatMap(Bool.init(from:)) ?? false
    usesScalarValueType = object[XML.Attributes.usesScalarValueType].flatMap(Bool.init(from:)) ?? false

    guard let nonoptionalType = object[XML.Attributes.attributeType]
                                  .flatMap(CoreData.AttributeType.init(rawValue:)) else {
      throw CoreData.ParserError.invalidFormat(reason: "Missing required attribute type on attribute declaration")
    }
    type = nonoptionalType

    customClassName = object[XML.Attributes.customClassName]

    typeName = type.typeName(usesScalarValueType: usesScalarValueType, customClassName: customClassName)
  }
}

extension CoreData.AttributeType {
  // swiftlint:disable:next cyclomatic_complexity
  func typeName(usesScalarValueType: Bool, customClassName: String?) -> String {
    switch self {
    case .binaryData:
      return "Data"
    case .boolean:
      return usesScalarValueType ? "Bool" : "NSNumber"
    case .date:
      return "Date"
    case .decimal:
      return "NSDecimalNumber"
    case .double:
      return usesScalarValueType ? "Double" : "NSNumber"
    case .float:
      return usesScalarValueType ? "Float" : "NSNumber"
    case .integer16:
      return usesScalarValueType ? "Int16" : "NSNumber"
    case .integer32:
      return usesScalarValueType ? "Int32" : "NSNumber"
    case .integer64:
      return usesScalarValueType ? "Int64" : "NSNumber"
    case .string:
      return "String"
    case .transformable:
      return customClassName ?? "AnyObject"
    case .URI:
      return "URL"
    case .UUID:
      return "UUID"
    }
  }
}