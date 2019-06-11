Pod::Spec.new do |s|
  s.name         = "OhhAuth"
  s.version      = "1.1.0"
  s.summary      = "Pure Swift implementation of the OAuth 1.0 protocol as an easy to use extension for the URLRequest type. (RFC-5849)"
  s.authors      = "Markus Wanke"
  s.homepage     = "https://github.com/mw99/OhhAuth"
  s.license      = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.source       = { :git => "https://github.com/mw99/OhhAuth.git", :tag => s.version }

  s.swift_version = '5'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true
end
