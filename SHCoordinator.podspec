Pod::Spec.new do |s|
  s.name             = 'SHCoordinator'
  s.version          = '2.0.0'
  s.summary          = 'It is a flow coordinator library that everyone can use.'

  s.homepage         = 'https://github.com/SHcommit/SHCoordinator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yangseunghyun' => 'happysh_s2@naver.com' }
  s.source           = { :git => 'https://github.com/SHcommit/SHCoordinator.git', 
                         :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.source_files          = 'Sources/SHCoordinator/**/*.{h,m,swift}'
  s.swift_version         = '5.0'  
  s.frameworks            = "UIKit"
end
