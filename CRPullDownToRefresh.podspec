Pod::Spec.new do |s|

  s.name         = "CRPullDownToRefresh"
  s.version      = "0.1.2"
  s.summary      = "A short description of CRPullDownToRefresh."

  s.description  = <<-DESC
                   A longer description of CRPullDownToRefresh in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/craquee/CRPullDownToRefresh"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Tomoya Igarashi" => "tomoya@couger.co.jp" }

  s.platform     = :ios, '5.1'

  s.source       = { :git => "git@github.com:craquee/CRPullDownToRefresh.git", :tag => "0.1.2" }

  s.source_files  = 'CRPullDownToRefresh/**/*.{h,m}'
  s.exclude_files = 'CRPullDownToRefresh/**/*Tests.{h,m}'

  s.resources = 'CRPullDownToRefresh/**/*.{xib,png}'

  s.requires_arc = true
end
