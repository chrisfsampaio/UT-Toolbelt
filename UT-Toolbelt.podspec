Pod::Spec.new do |s|
  s.name     = 'UT-Toolbelt'
  s.version  = '1.0'
  s.authors   = { 'Christian Sampaio' => 'christian.fsampaio@gmail.com' }
  s.homepage = 'https://github.com/chrisfsampaio/UT-Toolbelt'
  s.summary  = 'A set of utilities that should make UT with Objective-C easier'
  s.license  = 'MIT'
  s.source   = { :git => 'https://github.com/chrisfsampaio/UT-Toolbelt.git' }
  s.source_files = 'UT-Toolbelt/*.{h,m}', 'UT-Toolbelt/**/*.{h,m}'
  s.platform = :ios
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
  s.ios.frameworks = 'XCTest' 
end
