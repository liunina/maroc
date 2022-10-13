Pod::Spec.new do |s|
  s.name             = 'Maroc'
  s.version          = '0.1.0'
  s.summary          = "Maroc is a kind of modular programming method"

  s.description      = <<-DESC
    Developer can use BeeHive make iOS programming easier
                       DESC

  s.homepage         = 'https://github.com/liunina/Maroc'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liunina' => 'i19850511@gmail.com' }
  s.source           = { :git => 'https://github.com/liunina/Maroc.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Maroc/**/*.{h,m}'
  s.resource = 'Maroc/*.bundle'
  s.public_header_files = 'Maroc/**/*.h'
  s.frameworks = 'QuartzCore','UIKit'
  s.static_framework = true
end
