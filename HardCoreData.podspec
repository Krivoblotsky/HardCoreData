Pod::Spec.new do |s|
  s.name             = "HardCoreData"
  s.version          = "0.1.2"
  s.summary          = "CoreData stack and controller that will never block UI thread"
  s.description      = <<-DESC
                       HardCoreData is a yet another core data stack based on Marcus Zarra's multithreading approach. This smart approach uncouples the writing into its own private queue and keeps the UI smooth as button.
                       DESC
  s.homepage         = "https://github.com/Krivoblotsky/HardCoreData"
  s.license          = 'MIT'
  s.author           = { "Serg Krivoblotsky" => "krivoblotsky@me.com" }
  s.source           = { :git => "https://github.com/Krivoblotsky/HardCoreData.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Krivoblotsky'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
end
