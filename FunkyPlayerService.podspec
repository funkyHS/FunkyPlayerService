
Pod::Spec.new do |s|
  s.name             = 'FunkyPlayerService'
  s.version          = '0.1.2'
  s.summary          = 'FunkyPlayerService'

  s.description      = <<-DESC
TODO:FunkyPlayerService提供本地资源或远程资源的音频播放功能组件
                       DESC

  s.homepage         = 'https://github.com/funkyHS/FunkyPlayerService'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'funkyHS' => 'hs1024942667@163.com' }
  s.source           = { :git => 'https://github.com/funkyHS/FunkyPlayerService.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  # s.source_files = 'FunkyPlayerService/Classes/**/*'


s.subspec 'LocalPlayer' do |sb|
    sb.source_files = 'FunkyPlayerService/Classes/LocalPlayer/**/*'
end

s.subspec 'RemotePlayer' do |sb|
    sb.source_files = 'FunkyPlayerService/Classes/RemotePlayer/**/*'
end

s.subspec 'PlayerService' do |sb|
    sb.source_files = 'FunkyPlayerService/Classes/PlayerService/**/*'
    sb.dependency 'FunkyPlayerService/LocalPlayer'
    sb.dependency 'FunkyPlayerService/RemotePlayer'

end


end
