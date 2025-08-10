source 'https://github.com/CocoaPods/Specs.git'


platform :ios, '12.0'
inhibit_all_warnings!

target 'Drrrible' do
  use_frameworks!

  # Architecture
  pod 'ReactorKit'

  # Networking
  pod 'Alamofire'
  pod 'Moya', '14.0.0-beta.2'
  pod 'Moya/RxSwift'
  pod 'MoyaSugar',
    :git => 'https://github.com/devxoul/MoyaSugar.git',
    :branch => 'master'
  pod 'MoyaSugar/RxSwift',
    :git => 'https://github.com/devxoul/MoyaSugar.git',
    :branch => 'master'
  pod 'Kingfisher'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxCodable'
  pod 'RxDataSources'
  pod 'Differentiator'
  pod 'RxOptional'
  pod 'RxKeyboard'
  pod 'RxGesture'
  pod 'RxViewController'
  pod 'SectionReactor'

  # UI
  pod 'SnapKit'
  pod 'ManualLayout'
  pod 'TTTAttributedLabel'
  pod 'TouchAreaInsets'
  pod 'UICollectionViewFlexLayout'

  # Logging
  pod 'CocoaLumberjack/Swift'
  pod 'Umbrella'
  pod 'Umbrella/Firebase'

  # Misc.
  pod 'Then'
  pod 'ReusableKit'
  pod 'CGFloatLiteral'
  pod 'SwiftyColor'
  pod 'SwiftyImage'
  pod 'UITextView+Placeholder'
  pod 'URLNavigator'
  pod 'KeychainAccess'
  pod 'Immutable'
  pod 'Carte'

  # SDK
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Firebase/Core'

  target 'DrrribleTests' do
    inherit! :complete
    pod 'Stubber'
    pod 'Quick'
    pod 'Nimble'
  end

end

post_install do |installer|
  pods_dir = File.dirname(installer.pods_project.path)
  at_exit { `ruby #{pods_dir}/Carte/Sources/Carte/carte.rb configure` }
end
