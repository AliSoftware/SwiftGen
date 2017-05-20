//
//  plist.swift
//  SwiftGen
//
//  Created by Toshihiro Suzuki on 4/12/17.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import Commander
import PathKit
import StencilSwiftKit
import SwiftGenKit

let plistCommand = command(
  outputOption,
  templateNameOption,
  templatePathOption,
  VariadicOption<String>("param", [], description: "List of template parameters"),
  Argument<Path>("PATH", description: "Info.plist file", validator: fileExists)
) { output, templateName, templatePath, parameters, path in
  let parser = PlistParser()

  if path.extension == "plist" {
    parser.parse(at: path)
  } else {
    throw ArgumentError.invalidType(value: String(describing: path), type: "plist file", argument: nil)
  }

  do {
    let templateRealPath = try findTemplate(
      subcommand: "plist", templateShortName: templateName, templateFullPath: templatePath
    )
    let template = try StencilSwiftTemplate(templateString: templateRealPath.read(),
                                            environment: stencilSwiftEnvironment())
    let context = parser.stencilContext()
    let enriched = try StencilContext.enrich(context: context, parameters: parameters)
    let rendered = try template.render(enriched)
    output.write(content: rendered, onlyIfChanged: true)
  } catch {
    printError(string: "error: failed to render template \(error)")
  }
}
