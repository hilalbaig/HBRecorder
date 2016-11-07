#
# Be sure to run `pod lib lint HBRecorder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBRecorder'
  s.version          = '1.0.0'
  s.summary          = 'Video recording - HBRecorder.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Recording with pause and animation feature.'

  s.homepage         = 'https://github.com/hilalbaig/HBRecorder'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HilalB' => 'hilal.beg@gmail.com' }
  s.source           = { :git => 'https://github.com/hilalbaig/HBRecorder.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hilalbaig'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HBRecorder/Classes/**/*'
  
	s.resource_bundles = {
	    'HBRecorder' => ['HBRecorder/Assets/*.{lproj,storyboard}']
	  }
		
	s.resources = "HBRecorder/Assets/*.xcassets"
	


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SCRecorder'
end
