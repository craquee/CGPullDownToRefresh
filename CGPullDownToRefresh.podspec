Pod::Spec.new do |s|

  s.name         = "CGPullDownToRefresh"
  s.version      = "0.0.2"
  s.summary      = "A short description of CGPullDownToRefresh."

  s.description  = <<-DESC
                   A longer description of CGPullDownToRefresh in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://EXAMPLE/CGPullDownToRefresh"
  # s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"


  s.license      = { :type => 'MIT', :file => 'LICENSE' }


  s.author       = { "Tomoya Igarashi" => "tomoya@couger.co.jp" }
  # s.authors      = { "Tomoya Igarashi" => "tomoya@couger.co.jp", "other author" => "email@address.com" }
  # s.author       = 'Tomoya Igarashi', 'other author'


  # s.platform     = :ios
  s.platform     = :ios, '5.1'


  s.source       = { :git => "git@github.com:craquee/CGPullDownToRefresh.git", :tag => "0.0.2" }


  s.source_files  = 'CGPullDownToRefresh/**/*.{h,m}'
  s.exclude_files = 'CGPullDownToRefresh/**/*Tests.{h,m}'

  s.resources = 'CGPullDownToRefresh/**/*.{xib,png}'

  # s.framework  = 'SomeFramework'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'

  # s.library   = 'iconv'
  # s.libraries = 'iconv', 'xml2'


  s.requires_arc = true

  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  # s.dependency 'JSONKit', '~> 1.4'

end
