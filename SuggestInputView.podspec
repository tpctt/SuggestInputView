Pod::Spec.new do |s|
  s.name                  = "SuggestInputView"
  s.version               = "1.0.4"
  s.summary               = "SuggestInputView 常见的意见反馈部分的代码封装,支持图片和文本输入  "
  s.homepage              = "https://github.com/tpctt/SuggestInputView"
  s.social_media_url      = "https://github.com/tpctt/SuggestInputView"
  s.platform     = :ios,'8.0'
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { " tim" => "491590253@qq.com" }
  s.source                = { :git => "https://github.com/tpctt/SuggestInputView.git",:tag => s.version.to_s }
  s.ios.deployment_target = "8.0"
  s.requires_arc          = true
  s.framework             = "Foundation","UIKit"
  s.dependency 'ZLPhotoBrowser'#, '~> 2.0.2'

  s.source_files = 'Classess/**/*.{h,m,mm}'
  
  # s.library		= "z.1.1.3","stdc++","sqlite3"
  # s.subspec 'TableViewWithBlock' do |sp|
  #   sp.source_files = 'TableViewWithBlock/**/*.{h,m,mm}'
  # #  sp.resources   = "Extend/**/*.{png}"
  #   sp.requires_arc = true
   
  #  sp.dependency 'FontIcon'
  #  # sp.prefix_header_contents = '#import "EasyIOS.h"'
  # end
end
