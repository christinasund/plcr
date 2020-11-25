Pod::Spec.new do |s|

  s.name         = "TealiumCrashReporter"
  s.module_name         = "CrashReporter"
  s.version      = "1.5.0"
  s.summary      = "Fork of the Plausible Labs PLCrashReporter repo."
  s.description  = "This fork contains code that is not part of the core PLCrashReporter distribution.  This software is not provided by or maintained by Plausible Labs."

  s.homepage     = "https://github.com/tealium/plcrashreporter" 
  s.platform = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author             = { "Jonathan Wong" => "jonathan.wong@tealium.com" }

  s.source       = { :http     => "https://github.com/tealium/plcrashreporter/releases/download/#{s.version}/TealiumCrashReporter.framework.zip", :flatten  => true }
  s.requires_arc = false
  s.ios.vendored_frameworks  = "CrashReporter.framework"
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}

end