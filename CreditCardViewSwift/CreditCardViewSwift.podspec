Pod::Spec.new do |spec|

  spec.name                 = "CreditCardViewSwift"
  spec.version              = "1.0.2"
  spec.summary              = "This is a framework that lets you add a fully functional credit/debit card view"
  spec.description          = "A fully functional Credit/Debit card view that returns validated card data for use. Import this framework in your code, add it as a subview and you are ready to go!"
  spec.homepage             = "https://github.com/osamaazmat/CreditCardView"
  spec.license              = "MIT"
  spec.author               = { "Osama Azmat Khan" => "usama.azmat@hotmail.com" }
  spec.social_media_url     = "https://twitter.com/osamaazmat"
  spec.swift_version        = '5.0'
  spec.platform             = :ios, "13.4"
  spec.source               = { :git => "https://github.com/osamaazmat/CreditCardViewSwift.git", :tag => "1.0.2" }
  spec.source_files         = "CreditCardViewSwift/**/*"
  spec.exclude_files        = [ 'CreditCardViewSwift/**/*.xcuserstate', 'CreditCardViewSwift/**/*.plist' ]
  
  spec.dependency 'SkyFloatingLabelTextField', '~> 3.0'
end

