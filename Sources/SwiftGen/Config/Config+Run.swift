//
// SwiftGen
// Copyright © 2019 SwiftGen
// MIT Licence
//

import AppKit
import PathKit
import StencilSwiftKit
import SwiftGenKit

extension Config {
  func runActions(verbose: Bool) throws {
    let commandsAndEntries = try collectCommandsAndEntries()

    let errors = commandsAndEntries.parallelCompactMap { cmd, entry -> Swift.Error? in
      do {
        try run(cmd: cmd, entry: entry, verbose: verbose)
        return nil
      } catch {
        return error
      }
    }

    if errors.count == 1 {
      throw errors[0]
    } else if errors.count > 1 {
      throw Error.multipleErrors(errors)
    }
  }

  private func run(cmd: ParserCLI, entry: ConfigEntry, verbose: Bool) throws {
    var entry = entry

    entry.makingRelativeTo(inputDir: inputDir, outputDir: outputDir)
    if verbose {
      for item in entry.commandLine(forCommand: cmd.name) {
        logMessage(.info, " $ \(item)")
      }
    }

    try entry.checkPaths()
    try entry.run(parserCommand: cmd)
  }

  /// Flatten all commands and their corresponding entries into 1 list
  private func collectCommandsAndEntries() throws -> [(ParserCLI, ConfigEntry)] {
    try commands.keys.sorted()
      .map { cmd in
        guard let parserCmd = ParserCLI.command(named: cmd) else {
          throw Config.Error.unknownParser(name: cmd)
        }
        return parserCmd
      }
      .flatMap { cmd in
        (commands[cmd.name] ?? []).map { (cmd, $0) }
      }
  }
}

extension ConfigEntry {
  func run(parserCommand: ParserCLI) throws {
    let parser = try parserCommand.parserType.init(options: options) { msg, _, _ in
      logMessage(.warning, msg)
    }

    let filter = try Filter(pattern: self.filter ?? parserCommand.parserType.defaultFilter)
    try parser.searchAndParse(paths: inputs, filter: filter)
    let context = parser.stencilContext()

    for entryOutput in outputs {
      let templateRealPath = try entryOutput.template.resolvePath(forParser: parserCommand)
      let template = try StencilSwiftTemplate(
        templateString: templateRealPath.read(),
        environment: stencilSwiftEnvironment()
      )

      let enriched = try StencilContext.enrich(context: context, parameters: entryOutput.parameters)
      let rendered = try template.render(enriched)
      let output = OutputDestination.file(entryOutput.output)
      try output.write(content: rendered, onlyIfChanged: true)
    }
  }
}

// MARK: - Path checks

extension ConfigEntry {
  func checkPaths() throws {
    for inputPath in self.inputs {
      guard inputPath.exists else {
        throw Config.Error.pathNotFound(path: inputPath)
      }
    }
    for output in outputs {
      try output.checkPaths()
    }
  }
}

extension ConfigEntryOutput {
  func checkPaths() throws {
    guard self.output.parent().exists else {
      throw Config.Error.pathNotFound(path: self.output.parent())
    }
  }
}