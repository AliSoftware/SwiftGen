# SwiftGen CHANGELOG

---
## Master

#### Enhancements

* Added View Controller Placeholders support
[Viacheslav Karamov](https://github.com/vkaramov/), [#61](https://github.com/AliSoftware/SwiftGen/issues/61)

## 0.7.3

#### Fixes

* Restructured storyboard templates to work around an LLVM issue with nested types.

> Scenes and Segues are now referenced via `StoryboardScene.<Storyboard>` and `StoryboardSegue.<Storyboard>.<Segue>`

## 0.7.2

#### Enhancements

* Adding comments to generated color enums which allow you to see the color in the QuickHelp documentation

![colors QuickHelp](documentation/ColorsQuickHelp.png)

* The default translation of strings are now added as documentation comments to the enum cases.  
  _You can add translations to your own templates by using the `string.translation` variable._  
  [@MrAlek](https://github.com/MrAlek), [#58](https://github.com/AliSoftware/SwiftGen/issues/58), [#60](https://github.com/AliSoftware/SwiftGen/pull/60)

#### Fixes

* Fix an issue with the colors template due to an Apple Bug when building in Release and with WMO enabled.  
  [#56](https://github.com/AliSoftware/SwiftGen/issues/56)

## 0.7.1

#### Fixes

* Fix issue with `swiftgen strings` that were using the colors templates instead of the strings template by default.  
  [@ChristopherRogers](https://github.com/ChristopherRogers), [#54](https://github.com/AliSoftware/SwiftGen/pull/54)

## 0.7.0

#### Enhancements

* Allow using **custom templates by name**. ([#42](https://github.com/AliSoftware/SwiftGen/issues/42), [#50](https://github.com/AliSoftware/SwiftGen/pull/50))
  * Now the `-t` flag expect a template name (defaults to `default`), and will search a matching template in `Application Support` first, then in the templates bundled with SwiftGen.  
  * You can still specify a template by path using `-p`.  
  * For more info, see [this dedicated documentation](documentation/Templates.md).  
* You can now list all templates available (both bundled templates and custom ones) using the `swiftgen templates` command.
  ([#42](https://github.com/AliSoftware/SwiftGen/issues/42), [#50](https://github.com/AliSoftware/SwiftGen/pull/50))
* Add a `performSegue(_:sender:)` extension on `UIViewController` to accept a `StoryboardSegue` as parameter.  
  You can now for example call `vc.performSegue(UIStoryboard.Segue.Wizard.ShowPassword)`.
  ([#37](https://github.com/AliSoftware/SwiftGen/issues/37))

SwiftGen now comes bundled with some alternate templates, especially `colors-rawValue`, `images-allvalues` and `storyboards-lowercase`, in addition to the default templates.

#### Fixes

* Now `swiftgen storyboards` doesn't generate duplicate enum cases for identical segues (those having equal identifiers and shared custom class).  
  [@filwag](https://github.com/filwag), [#43](https://github.com/AliSoftware/SwiftGen/pull/43)
* Fix compilation issue for storyboards without any scene.  
  [Viacheslav Karamov](https://github.com/vkaramov/), [#47](https://github.com/AliSoftware/SwiftGen/issues/47)
* Propose an alternate template using lowercase names, especially for when storyboard identifiers match view controller class names.  
  [Viacheslav Karamov](https://github.com/vkaramov/), [#48](https://github.com/AliSoftware/SwiftGen/issues/48)
* Introduced an `image-allvalues` template that exposes the list of all images in a `static let allValues` array.  
  [Ahmed Mseddi](https://github.com/amseddi) & Guillaume Lagorce, [#44](https://github.com/AliSoftware/SwiftGen/pull/44)
* Fix issue with Storyboards without any StoryboardID (all scenes being anonymous) not extending `StoryboardScene`.
  ([#36](https://github.com/AliSoftware/SwiftGen/issues/36))

## 0.6.0

### New Features: Templates

* `SwiftGen` now uses [Stencil](https://github.com/kylef/Stencil) template engine to produce the generated code.
* This means that the generate code will be easier to improve
* This also means that **you can use your own templates** to generate code that better suits your needs and preferences, using `swiftgen … --template FILE …`

### Fixes

* The correct type of _ViewController_ (`UIViewController`, `UINavigationController`, `UITableViewController`, …) is now correctly generated even if not a custom subclass.  ([#40](https://github.com/AliSoftware/SwiftGen/issues/40))
* Fix issue with `.strings` files encoded in UTF8 ([#21](https://github.com/AliSoftware/SwiftGen/issues/21))

## 0.5.2

### New Features

* It's now possible to specify which chars should not be used when generating `case` identifiers.  
[@Igor-Palaguta](https://github.com/Igor-Palaguta), [#34](https://github.com/AliSoftware/SwiftGen/pull/34)

## 0.5.1

#### Fixes

* Installing via `rake install` or `brew install` will now copy the Swift dylibs too, so that `swiftgen` installation won't depend on the location of your Xcode.app (so it'll work on every machine even if you rename your Xcode).
* Fixed links in Playground and Licence headers in source code.

## 0.5.0

#### New Features

* Migrating to [Commander](https://github.com/kylef/Commander) to parse the CLI arguments. ([23](https://github.com/AliSoftware/SwiftGen/issues/23), [#30](https://github.com/AliSoftware/SwiftGen/issues/30))
* `swiftgen` is now a single binary, and the subcommand names have changed to be more consistent. ([#30](https://github.com/AliSoftware/SwiftGen/issues/30))
* New `--output` option. ([#30](https://github.com/AliSoftware/SwiftGen/issues/30))

> You must now use the subcommands `swiftgen images`, `swiftgen strings`, `swiftgen storyboards` and `swiftgen colors`. See `swiftgen --help` for more usage info.

#### Fixes

* Fix color parsing with absent alpha  
[@Igor-Palaguta](https://github.com/Igor-Palaguta), [#28](https://github.com/AliSoftware/SwiftGen/pull/28)

## 0.4.4

* Updated Unit tests for latest Swift 2.0 & tested against Xcode 7.1
* Fix small typos in code
* Guard against empty `enums`  

## 0.4.3

* Updated for Xcode 7 Beta 6  
[@Dimentar](https://github.com/Dimentar), [#14](https://github.com/AliSoftware/SwiftGen/pull/14)

## 0.4.2

* Added `import Foundation` on top of `swiftgen-l10n` generated code  
[@Nick11](https://github.com/Nick11), [#12](https://github.com/AliSoftware/SwiftGen/pull/12)

## 0.4.1

* Updated for Xcode 7 Beta 5
* `swiftgen-storyboard` now allows to take a path to a `.storyboard` file as argument (as an alternative to give a path to a whole directory)
* The `-v` and `--version` flags are now recognized and print the executable version.

## 0.4.0

* Reorganized files into an **Xcode project** with one target per executable ([#2](https://github.com/AliSoftware/SwiftGen/issues/2))
* Added **Unit Tests** (one per executable + one for common code) ([#2](https://github.com/AliSoftware/SwiftGen/issues/2))
* Improved `SwiftGen-L10n` parsing of format strings and placeholders. ([#4](https://github.com/AliSoftware/SwiftGen/issues/4), [#5](https://github.com/AliSoftware/SwiftGen/issues/5), [#6](https://github.com/AliSoftware/SwiftGen/issues/6))
* Updated `Rakefile` so that it now invokes `xcodebuild install`. You can now easily build & install all `swiftgen-xxx` executables in `/usr/local/bin` or anywhere else.
* Added a **version** string (date + sha1) to the built executables (displayed when invoked with no argument)

## 0.3.0

* Reducted the default code generated by `SwiftGenColorEnumBuilder` to avoid clobbering the `UIColor` namespace
* Changed the "namespacing `enum`" in `UIStoryboard` to a `struct` to avoid confusion with the inner enums
* The `UIStoryboard.Scene` enums now use `static func` instead of `static var` for the dedicated `ViewController` constructors ^(†)

^(†) _because it feels more explicit that calling a function like `UIStoryboard.Scene.Wizard.validatePasswordViewController()` will actually **instanciate** a new `ViewController`, rather than returning an existing one._

## 0.2.0

* Added `Segues` enums to `UIStoryboard` to be able to access their identifiers easily.  
[@esttorhe](https://github.com/esttorhe), [#8](https://github.com/AliSoftware/SwiftGen/pull/8)
* Added this very `CHANGELOG.md`

## 0.1.0

Considered to be the first cleaned-up version, far from finished but really usable with clean code.

* Cleaner README
* Namespace the generated `enums` in an outer `enum` to avoid clobbering the `UIStoryboard` namespace

## 0.0.4

* Introducing `SwiftGenColorEnumBuilder`
* `swiftgen-colors` CLI
* Added ability to choose indentation
* 

## 0.0.3

* Introducing `SwiftGenL10nEnumBuilder`
* `swiftgen-l10n` CLI
* Started playing with `UIColor` enums in the playground

## 0.0.2

* Introducing `SwiftGenStoryboardEnumBuilder` class
* `swiftgen-storyboard` CLI

## 0.0.1

Initial version:

* Mostly testing stuff in a playground
* Introducing `SwiftGenAssetsEnumBuilder` class
* `swiftgen-assets` CLI

