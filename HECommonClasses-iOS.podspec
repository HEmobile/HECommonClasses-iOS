Pod::Spec.new do |s|

  s.name         = "HECommonClasses-iOS"
  s.version      = "0.0.8"
  s.summary      = "Common classes in HE:mobile projects."

  s.description  = "A few classes that we use commonly in the several projects that we work on HE:mobile."

  s.homepage     = "http://www.hemobile.com.br"

  s.license      = 'MIT'

  s.author       = { "HE:mobile" => "contato@hemobile.com.br" }

  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/HEmobile/HECommonClasses-iOS.git", :tag => "0.0.4" }

  s.source_files  = 'HECommonClasses', 'HECommonClasses/*.{h,m}'

  s.requires_arc = true
end
