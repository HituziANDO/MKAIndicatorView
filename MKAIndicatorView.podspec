Pod::Spec.new do |s|
  s.name          = "MKAIndicatorView"
  s.version       = "2.0.0"
  s.summary       = "MKAIndicatorView is simple and powerful indicator view."
  s.description   = <<-DESC
  MKAIndicatorView makes you to create the powerful indicator view easily.
                   DESC
  s.homepage      = "https://github.com/HituziANDO/MKAIndicatorView"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = "Hituzi Ando"
  s.platform      = :ios, "9.3"
  s.source        = { :git => "https://github.com/HituziANDO/MKAIndicatorView.git", :tag => "#{s.version}" }
  s.source_files  = "MKAIndicatorView/MKAIndicatorView/**/*.{h,m}"
  s.exclude_files = "MKAIndicatorView/build/*", "MKAIndicatorView/Framework/*"
  s.requires_arc  = true
end
