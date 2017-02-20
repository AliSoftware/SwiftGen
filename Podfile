platform :osx, '10.9'
use_frameworks!

def common_pods
  pod 'Stencil', '~> 0.8.0', :inhibit_warnings => true
  pod 'PathKit', '~> 0.8.0', :inhibit_warnings => true
  pod 'StencilSwiftKit', '~> 1.0.0'
#  pod 'SwiftGenKit', '~> 1.0.1'
  pod 'SwiftGenKit', :git => 'https://github.com/AFcgi/SwiftGenKit', :branch => 'feature/font_file'
end

target 'swiftgen' do
  pod 'Commander', '~> 0.6.0', :inhibit_warnings => true
  common_pods
end

target 'UnitTests' do
  common_pods
end
