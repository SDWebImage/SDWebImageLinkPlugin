#
# Be sure to run `pod lib lint SDWebImageLinkPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDWebImageLinkPlugin'
  s.version          = '0.3.0'
  s.summary          = 'A SDWebImage loader plugin, to support load rich link image with LinkPresentation framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SDWebImageLinkPlugin is a plugin for SDWebImage framework, which provide the image loading support for rich link URL, by using the Link Presentation framework introduced in iOS 13/macOS 10.15.
                       DESC

  s.homepage         = 'https://github.com/SDWebImage/SDWebImageLinkPlugin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DreamPiggy' => 'lizhuoli1126@126.com' }
  s.source           = { :git => 'https://github.com/SDWebImage/SDWebImageLinkPlugin.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'

  s.source_files = 'SDWebImageLinkPlugin/Classes/**/*', 'SDWebImageLinkPlugin/Module/SDWebImageLinkPlugin.h'
  
  s.pod_target_xcconfig = {
    'SUPPORTS_MACCATALYST' => 'YES',
    'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO'
  }
  
  s.dependency 'SDWebImage', '~> 5.4'
  s.weak_frameworks = 'LinkPresentation'
end
