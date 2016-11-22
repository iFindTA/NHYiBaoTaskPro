Pod::Spec.new do |s|

  s.name         = "PBFixedNavigator"
  s.version      = "0.0.2"
  s.summary      = "PBFixedNavigator is an Objc Wrapper for fixed sub navigator."
  s.homepage     = "https://github.com/iFindTA"
  s.description  = "SSL En/Decrypt warpper by Objc Include AES/RSA signature and verify data for ios"
  s.license      = "MIT(LICENSE)"
  s.author             = { "nanhujiaju" => "nanhujiaju@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/iFindTA/NHYiBaoTaskPro.git", :tag => s.version.to_s }
  s.source_files  = "NHYiBaoTaskPro/UIComponents/PBFixedNavigator/*.{h,m}"
  s.public_header_files = "NHYiBaoTaskPro/UIComponents/PBFixedNavigator/*.h"

  s.framework  = "UIKit","Foundation"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true
  # s.dependency "JSONKit", "~> 1.4"
  end

