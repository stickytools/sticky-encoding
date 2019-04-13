
Pod::Spec.new do |s|
  s.name              = "StickyEncoding"
  s.version           = "1.0.0-beta.5"
  s.summary           = "High-performance binary encoding/decoding of `Swift.Codable` types."
  s.description       = <<-DESC
                             **StickyEncoding, high-performance binary encoding/decoding for `Swift.Codable` types.
                        DESC
  s.license           = 'Apache License, Version 2.0'
  s.homepage          = "https://github.com/stickytools/sticky-encoding"
  s.author            = { "Tony Stone" => "https://github.com/tonystone" }
  s.source            = { :git => "https://github.com/stickytools/sticky-encoding.git", :tag => s.version.to_s }
  s.documentation_url = 'https://stickytools.io/sticky-encoding/index.html'

  s.swift_version = '4.2'

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'

  s.requires_arc = true
  s.source_files = 'Sources/StickyEncoding/**/*.swift'
end
