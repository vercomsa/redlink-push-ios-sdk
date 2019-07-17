#
#  Be sure to run `pod spec lint Hydra.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name            = "Redlink"
  s.version         = "1.1.2"
  s.swift_version   = '4.0'
  s.summary         = "Redlink Push Notifications"
  s.ios.deployment_target = '10.0'
  s.homepage        = "https://www.redlink.pl"
  s.author          = { "Redlink" => "sales@redlink.pl" }
  s.license =    { :type => 'proprietary', :text => <<-LICENSE
    Copyright 2019 - present Redlink. All rights reserved.
    LICENSE
  }
  s.ios.vendored_frameworks = 'Framework/Redlink.framework'
  s.source          = { :git => 'https://github.com/vercomsa/redlink-push-ios-sdk.git', :tag => s.version.to_s }
  s.dependency 'SQLite.swift', '0.11.5'

end
