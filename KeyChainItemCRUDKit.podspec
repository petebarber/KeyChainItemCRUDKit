Pod::Spec.new do |s|
  s.name         = "KeyChainItemCRUDKit"
  s.version      = "0.0.3"
  s.summary      = "Swift library to CRUD instances of NSData or objects implementing NSCoding into the iOS KeyChain."
  s.description  = <<-DESC
  
  Having authenticated with a web service using OAuth2 and received the tokens I wanted to be able store them
  sercurely. Whilst investigating secure storage on iOS I came across the ability to store small amounts of
  data in the iOS Keychain. As the set of OAuth tokens is a couple of strings and number representing the
  time to live of the token then this seemed like the ideal mechanism.
  
  However, the Keychain API isn't that simple nor succint to use and can only store a single piece of data. 
  This single piece of data can be an instance of NSData this means arbitrary objects can be stored.
  I created a small library that allowd the Creation, Reading, Updating and Deletion (CRUD) of instances of
  NSData. Futher rather than having to create instances of NSData I provided a layer on top that manipulates
  any object that supports NSCoding.

  Version 0.0.3 is Swift 2.1. The previous version is pre-2.0.
                   
                   DESC

  s.homepage     = "https://github.com/petebarber/KeyChainItemCRUDKit"
  s.license      = 'MIT'

  s.author             = { "pete" => "pete.barber@gmail.com" }
  s.social_media_url   = "https://twitter.com/foobarber"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/petebarber/KeyChainItemCRUDKit.git", :tag => "0.0.3" }

  s.source_files  = "KeyChainItemCRUDKit/KeyChainItemCRUDKit/*.swift"
  s.exclude_files = "Classes/Exclude"
end
