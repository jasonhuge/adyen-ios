version = `agvtool vers -terse`

Pod::Spec.new do |s|
  s.name = 'Adyen'
  s.version = version
  s.summary = "Adyen SDK for iOS"
  s.description = <<-DESC
    With Adyen SDK you can dynamically list all relevant payment methods for a specific transaction, so your shoppers can always pay with the method of their choice. The methods are listed based on the shopper's country, the transaction currency and amount.
  DESC

  s.homepage = 'https://adyen.com'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Adyen' => 'support@adyen.com' }
  s.source = { :git => 'https://github.com/Adyen/adyen-ios.git', :tag => "#{s.version}" }
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.frameworks = 'Foundation'
  s.default_subspecs = 'Core', 'Card', 'SEPA'

  s.subspec 'Core' do |plugin|
    plugin.source_files = 'Adyen/**/*.swift'
    plugin.dependency 'AdyenInternal', version
  end

  # Payment Methods
  s.subspec 'ApplePay' do |plugin|
    plugin.source_files = 'AdyenApplePay/**/*.swift'
    plugin.dependency 'Adyen/Core'
  end

  s.subspec 'Card' do |plugin|
    plugin.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '${PODS_TARGET_SRCROOT}/AdyenCard/AdyenCSE' }
    plugin.preserve_paths = 'AdyenCard/AdyenCSE/module.modulemap'
    plugin.dependency 'Adyen/Core'
    plugin.source_files = 'AdyenCard/**/*.swift', 'AdyenCard/AdyenCSE/*.{h,m}'
    plugin.private_header_files = 'AdyenCard/AdyenCSE/*.h'
  end

  s.subspec 'SEPA' do |plugin|
    plugin.source_files = 'AdyenSEPA/**/*.swift'
    plugin.dependency 'Adyen/Core'
  end

end
