Pod::Spec.new do |s|
  s.name             = 'oHTTP'
  s.version          = '0.1.0'
  s.summary          = 'Simple way to use mutable token with Alamofire'

  s.homepage         = 'https://github.com/ZupIT/oHTTP'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.author           = { 'Diego Louli' => 'diego.louli@gmail.com' }

  s.source           = { :git => 'https://github.com/ZupIT/oHTTP.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'oHTTP/Classes/**/*'

  s.dependency 'Alamofire'
end
