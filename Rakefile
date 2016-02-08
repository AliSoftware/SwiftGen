#!/usr/bin/rake
require 'pathname'

## [ Constants ] ##############################################################

BIN_NAME = 'swiftgen'
DEPENDENCIES = [:PathKit, :Stencil, :Commander, :GenumKit]
CONFIGURATION = 'Release'
BUILD_DIR = 'build/' + CONFIGURATION
TEMPLATES_SRC_DIR = 'templates'

## [ Utils ] ##################################################################

def xcpretty(cmd)
  if `which xcpretty` && $?.success?
    sh "set -o pipefail && #{cmd} | xcpretty -c"
  else
    sh cmd
  end
end

def print_info(str)
  (red,clr) = (`tput colors`.chomp.to_i >= 8) ? %W(\e[33m \e[m) : ["", ""]
  puts red, str.chomp, clr
end

def defaults(args)
  bindir = args.bindir.nil? || args.bindir.empty? ? Pathname.new('./build/swiftgen/bin')   : Pathname.new(args.bindir)
  fmkdir = args.fmkdir.nil? || args.fmkdir.empty? ? bindir + '../lib'   : Pathname.new(args.fmkdir)
  tpldir = args.tpldir.nil? || args.tpldir.empty? ? bindir + '../templates' : Pathname.new(args.tpldir)
  [bindir, fmkdir, tpldir]
end

task :check_xcode do
  xcode_dir = `xcode-select -p`.chomp
  xcode_version = `mdls -name kMDItemVersion -raw "#{xcode_dir}"/../..`.chomp
  unless xcode_version.start_with?('7.')
    raise "\n[!!!] You need to use Xcode 7.x to compile SwiftGen. Use xcode-select to change the Xcode used to build from command line.\n\n"
  end
end

## [ Build Tasks ] ############################################################

desc "Build the CLI binary and its frameworks in #{BUILD_DIR}"
task :build, [:bindir, :tpldir] => [:check_xcode] + DEPENDENCIES do |_, args|
  (bindir, _, tpldir) = defaults(args)
  tpl_rel_path = tpldir.relative_path_from(bindir)
  main = File.read('swiftgen-cli/main.swift')
  File.write('swiftgen-cli/main.swift', main.gsub(/^let TEMPLATES_RELATIVE_PATH = .*$/, %Q(let TEMPLATES_RELATIVE_PATH = "#{tpl_rel_path}")))

  print_info "== Building Binary =="
  frameworks = DEPENDENCIES.map { |fmk| "-framework #{fmk}" }.join(" ")
  xcpretty %Q(xcrun -sdk macosx swiftc -O -o #{BUILD_DIR}/#{BIN_NAME} -F #{BUILD_DIR}/ #{frameworks} swiftgen-cli/*.swift)
end

DEPENDENCIES.each do |fmk|
  # desc "Build #{fmk}.framework"
  task fmk do
    print_info "== Building  #{fmk}.framework =="
    xcpretty %Q(xcodebuild -project Pods/Pods.xcodeproj -target #{fmk} -configuration #{CONFIGURATION})
  end
end

desc "Build the CLI and link it so it can be run from #{BUILD_DIR}. Useful for testing without installing."
task :link => :build do
  sh %Q(install_name_tool -add_rpath "@executable_path" #{BUILD_DIR}/#{BIN_NAME})
end

## [ Install Tasks ] ##########################################################

desc "Install the binary in $bindir, frameworks — without the Swift dylibs — in $fmkdir, and templates in $tpldir\n" \
     "(defaults $bindir=./swiftgen/bin/, $fmkdir=$bindir/../lib, $tpldir=$bindir/../templates"
task 'install:light', [:bindir, :fmkdir, :tpldir] => :build do |_, args|
  (bindir, fmkdir, tpldir) = defaults(args)

  print_info "== Installing binary in #{bindir} =="
  sh %Q(mkdir -p #{bindir})
  sh %Q(cp -f "#{BUILD_DIR}/#{BIN_NAME}" #{bindir})

  print_info "== Installing frameworks in #{fmkdir} =="
  sh %Q(mkdir -p #{fmkdir})
  DEPENDENCIES.each do |fmk|
    sh %Q(cp -fr "#{BUILD_DIR}/#{fmk}.framework" #{fmkdir})
  end
  sh %Q(install_name_tool -add_rpath "@executable_path/#{fmkdir.relative_path_from(bindir)}" #{bindir}/#{BIN_NAME})

  print_info "== Installing templates in #{tpldir} =="
  sh %Q(mkdir -p #{tpldir})
  sh %Q(cp -r #{TEMPLATES_SRC_DIR}/ #{tpldir})
end

desc "Install the binary in $bindir, frameworks — including Swift dylibs — in $fmkdir, and templates in $tpldir\n" \
     "(defaults $bindir=./swiftgen/bin/, $fmkdir=$bindir/../lib, $tpldir=$bindir/../templates"
task :install, [:bindir, :fmkdir, :tpldir] => 'install:light' do |_, args|
  (bindir, fmkdir, tpldir) = defaults(args)

  print_info "== Linking to standalone Swift dylibs =="
  sh %Q(xcrun swift-stdlib-tool --copy --scan-executable #{bindir}/#{BIN_NAME} --platform macosx --destination #{fmkdir})
  toolchain_dir = `xcrun -find swift-stdlib-tool`.chomp
  xcode_rpath = File.dirname(File.dirname(toolchain_dir)) + '/lib/swift/macosx'
  sh %Q(xcrun install_name_tool -delete_rpath "#{xcode_rpath}" #{bindir}/#{BIN_NAME})
end

## [ Tests & Clean ] ##########################################################

desc "Run the Unit Tests"
task :tests do
  xcpretty %Q(xcodebuild -workspace SwiftGen.xcworkspace -scheme swiftgen-cli -sdk macosx test)
end

desc "Delete the build/ directory"
task :clean do
  sh %Q(rm -fr build)
end

task :default => [:dependencies, :build]


## [ Playground Resources ] ###################################################

namespace :playground do
  task :clean do
    sh 'rm -rf SwiftGen.playground/Resources'
    sh 'mkdir SwiftGen.playground/Resources'
  end
  task :images do
    sh %Q(xcrun actool --compile SwiftGen.playground/Resources --platform iphoneos --minimum-deployment-target 7.0 --output-format=human-readable-text UnitTests/fixtures/Images.xcassets)
  end
  task :storyboard do
    sh %Q(xcrun ibtool --compile SwiftGen.playground/Resources/Wizard.storyboardc --flatten=NO UnitTests/fixtures/Wizard.storyboard)
  end
  task :strings do
    sh %Q(xcrun plutil -convert binary1 -o SwiftGen.playground/Resources/Localizable.strings UnitTests/fixtures/Localizable.strings)
  end

  desc "Regenerate all the Playground resources based on the test fixtures.\nThis compiles the needed fixtures and place them in SwiftGen.playground/Resources"
  task :resources => %w(clean images storyboard strings)
end

