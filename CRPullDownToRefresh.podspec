Pod::Spec.new do |s|

  s.name         = "CRPullDownToRefresh"
  s.version      = "0.1.1"
  s.summary      = "A short description of CRPullDownToRefresh."

  s.description  = <<-DESC
                   A longer description of CRPullDownToRefresh in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/craquee/CRPullDownToRefresh"
  # s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"


  s.license      = { :type => 'MIT', :file => 'LICENSE' }


  s.author       = { "Tomoya Igarashi" => "tomoya@couger.co.jp" }
  # s.authors      = { "Tomoya Igarashi" => "tomoya@couger.co.jp", "other author" => "email@address.com" }
  # s.author       = 'Tomoya Igarashi', 'other author'


  # s.platform     = :ios
  s.platform     = :ios, '5.1'


  s.source       = { :git => "git@github.com:craquee/CRPullDownToRefresh.git", :tag => "0.1.1" }


  s.source_files  = 'CRPullDownToRefresh/**/*.{h,m}'
  s.exclude_files = 'CRPullDownToRefresh/**/*Tests.{h,m}'

  s.resources = 'CRPullDownToRefresh/**/*.{xib,png}'

  # s.framework  = 'SomeFramework'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'

  # s.library   = 'iconv'
  # s.libraries = 'iconv', 'xml2'


  s.requires_arc = true

  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  # s.dependency 'JSONKit', '~> 1.4'

end
