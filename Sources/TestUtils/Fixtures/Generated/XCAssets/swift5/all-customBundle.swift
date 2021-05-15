// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import ARKit
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  enum Files {
    static let data = DataAsset(name: "Data")
    enum Json {
      static let data = DataAsset(name: "Json/Data")
    }
    static let readme = DataAsset(name: "README")
  }
  enum Food {
    enum Exotic {
      static let banana = ImageAsset(name: "Exotic/Banana")
      static let mango = ImageAsset(name: "Exotic/Mango")
    }
    enum Round {
      static let apricot = ImageAsset(name: "Round/Apricot")
      static let apple = ImageAsset(name: "Round/Apple")
      enum Double {
        static let cherry = ImageAsset(name: "Round/Double/Cherry")
      }
      static let tomato = ImageAsset(name: "Round/Tomato")
    }
    static let `private` = ImageAsset(name: "private")
  }
  enum Other {
  }
  enum Styles {
    enum _24Vision {
      static let background = ColorAsset(name: "24Vision/Background")
      static let primary = ColorAsset(name: "24Vision/Primary")
    }
    static let orange = ImageAsset(name: "Orange")
    enum Vengo {
      static let primary = ColorAsset(name: "Vengo/Primary")
      static let tint = ColorAsset(name: "Vengo/Tint")
    }
  }
  enum Symbols {
    static let exclamationMark = SymbolAsset(name: "Exclamation Mark")
    static let plus = SymbolAsset(name: "Plus")
  }
  enum Targets {
    static let bottles = ARResourceGroupAsset(name: "Bottles")
    static let paintings = ARResourceGroupAsset(name: "Paintings")
    static let posters = ARResourceGroupAsset(name: "Posters")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

struct ARResourceGroupAsset {
  fileprivate(set) var name: String

  #if os(iOS)
  @available(iOS 11.3, *)
  var referenceImages: Set<ARReferenceImage> {
    return ARReferenceImage.referenceImages(in: self)
  }

  @available(iOS 12.0, *)
  var referenceObjects: Set<ARReferenceObject> {
    return ARReferenceObject.referenceObjects(in: self)
  }
  #endif
}

#if os(iOS)
@available(iOS 11.3, *)
extension ARReferenceImage {
  static func referenceImages(in asset: ARResourceGroupAsset) -> Set<ARReferenceImage> {
    let bundle = ResourcesBundle.bundle
    return referenceImages(inGroupNamed: asset.name, bundle: bundle) ?? Set()
  }
}

@available(iOS 12.0, *)
extension ARReferenceObject {
  static func referenceObjects(in asset: ARResourceGroupAsset) -> Set<ARReferenceObject> {
    let bundle = ResourcesBundle.bundle
    return referenceObjects(inGroupNamed: asset.name, bundle: bundle) ?? Set()
  }
}
#endif

internal final class ColorAsset {
  fileprivate(set) var name: String

  #if os(macOS)
  typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = ResourcesBundle.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = ResourcesBundle.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

struct DataAsset {
  fileprivate(set) var name: String

  @available(iOS 9.0, tvOS 9.0, watchOS 6.0, macOS 10.11, *)
  var data: NSDataAsset {
    guard let data = NSDataAsset(asset: self) else {
      fatalError("Unable to load data asset named \(name).")
    }
    return data
  }
}

@available(iOS 9.0, tvOS 9.0, watchOS 6.0, macOS 10.11, *)
extension NSDataAsset {
  convenience init?(asset: DataAsset) {
    let bundle = ResourcesBundle.bundle
    #if os(iOS) || os(tvOS) || os(watchOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}

struct ImageAsset {
  fileprivate(set) var name: String

  #if os(macOS)
  typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  var image: Image {
    let bundle = ResourcesBundle.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = ResourcesBundle.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = ResourcesBundle.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

struct SymbolAsset {
  fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(watchOS)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  typealias Configuration = UIImage.SymbolConfiguration
  typealias Image = UIImage

  @available(iOS 12.0, tvOS 12.0, watchOS 5.0, *)
  var image: Image {
    let bundle = ResourcesBundle.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load symbol asset named \(name).")
    }
    return result
  }

  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
  internal func image(with configuration: Configuration) -> Image {
    let bundle = ResourcesBundle.bundle
    guard let result = Image(named: name, in: bundle, with: configuration) else {
      fatalError("Unable to load symbol asset named \(name).")
    }
    return result
  }
  #endif
}
