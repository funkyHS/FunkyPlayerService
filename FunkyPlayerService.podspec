
Pod::Spec.new do |s|
  s.name             = 'FunkyPlayerService'
  s.version          = '0.1.0'
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
    sb.source_files = 'FunkyFMBase/Classes/LocalPlayer/**/*'
end

s.subspec 'RemotePlayer' do |sb|
    sb.source_files = 'FunkyFMBase/Classes/RemotePlayer/**/*'
end

s.subspec 'PlayerService' do |sb|
    sb.source_files = 'FunkyPlayerService/Classes/**/*'
end


end
