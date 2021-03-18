# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'

# Pods for ebooks
def common_pods
  pod 'SwiftLint'
  pod 'Alamofire'
  pod 'PromiseKit'
  pod 'Kingfisher'
  pod 'OHHTTPStubs/Swift'
end

# Pods for ebooks Testing
def test_pods
  pod 'OHHTTPStubs/Swift'
end

target 'ebooks' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  common_pods
  
  # Pods for ebooks
  
  target 'ebooksTests' do
    inherit! :search_paths
    # Pods for testing
    test_pods
  end
  
end

target 'ebooksUITests' do
  # Pods for testing
end
