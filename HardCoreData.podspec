Pod::Spec.new do |s|
  s.name             = "HardCoreData"
  s.version          = "0.1.0"
  s.summary          = "A short description of HardCoreData."
  s.description      = <<-DESC
                       An optional longer description of HardCoreData

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/Krivoblotsky/HardCoreData"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Serg Krivoblotsky" => "krivoblotsky@me.com" }
  s.source           = { :git => "https://github.com/Krivoblotsky/HardCoreData.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Krivoblotsky'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
