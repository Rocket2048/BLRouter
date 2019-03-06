#
# Be sure to run `pod lib lint BLRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BLRouter'
  s.version          = '0.1.0'
  s.summary          = 'BLRouter'
  s.swift_version    = '4.0'
  
  s.description      = <<-DESC
  MGJRouer swift AppComponent
                       DESC

  s.homepage         = 'https://github.com/iosBob/BLRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lin bo' => 'ok@linbok.com' }
  s.source           = { :git => 'https://github.com/iosBob/BLRouter.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'BLRouter/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
end
