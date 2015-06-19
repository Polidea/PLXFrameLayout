Pod::Spec.new do |s|
  s.name             = "FrameLayout"
  s.version          = "0.1"
  s.homepage         = "https://github.com/Polidea/FrameLayout"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Pawel Scibek" => "pawel.scibek@polidea.com" }
  s.source           = { :git => "https://github.com/Polidea/FrameLayout.git", :tag => s.version.to_s }

  s.platform         = :ios, '6.0'
  s.requires_arc     = true

  s.source_files     = 'Framework/**/*'

  s.summary          = "FrameLayout is a tool for positioning, sizing and arranging views without using CGRects."
end
