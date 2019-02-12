#
# Be sure to run `pod lib lint StickyEncoding.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StickyEncoding"
  s.version          = "1.0.0-beta.2"
  s.summary          = "A high performance binary encoder for `Swift.Codable` types."
  s.description      = <<-DESC
                             **StickyEncoding**, A high performance binary encoder for `Swift.Codable` types.
                       DESC
  s.license          = 'Apache License, Version 2.0'
  s.homepage         = "https://github.com/stickytools/sticky-encoding"
  s.author           = { "Tony Stone" => "https://github.com/tonystone" }
  s.source           = { :git => "https://github.com/stickytools/sticky-encoding.git", :tag => s.version.to_s }

  s.swift_version = '4.2'

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'

  s.requires_arc = true
  s.source_files = 'Sources/StickyEncoding/**/*.swift'
end
