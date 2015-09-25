Pod::Spec.new do |s|
  s.name             = "PLXFrameLayout"
  s.version          = "0.1.2"
  s.homepage         = "https://github.com/Polidea/PLXFrameLayout"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "iOS Team at Polidea" => "ios-devs@polidea.com" }
  s.source           = { :git => "https://github.com/Polidea/PLXFrameLayout.git", :tag => s.version.to_s }

  s.platform         = :ios, '7.0'
  s.requires_arc     = true

  s.source_files     = 'Framework/**/*'

  s.summary          = "FrameLayout is a tool for positioning, sizing and arranging views without using CGRects."
end
