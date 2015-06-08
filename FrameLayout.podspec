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

  s.summary          = "A short description of FrameLayout."
  s.description      = <<-DESC
                       An optional longer description of FrameLayout

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC

end
