KeyChainItemCRUDKit
===================

A simple Swift library to CRUD instances of NSData and/or objects implementing NSCoding into the iOS KeyChain 

## Features

- Simple library for Saving, Loading & Deleting NSCoding compatable objects into the iOS Keychain (single class)
- Full Create, Read, Update & Delete semantics if required
- In Swift
- Available as a CocoaPod

## Use

There are 2 interfaces to this library

- KeyChainItemCRUD
- KeyChainItem

Both classes are constructed using 2 values: the BundleId of your application (though it can be any string in practice) and a unique key (also a string) to
identify your item.

### KeyChainItemCRUD

let itemCRUDer = KeyChainItemCRUD(bundleId: NSBundle.mainBundle().bundleIdentifier!, keyChainItemKey: "something")

then the methods

- createItem(data: NSData) -> Bool
- readItem() -> NSData?
- updateItem(data: NSData) -> Bool
- deleteItem() -> Bool

can be called

The major difference between these methods and the higher level ones following is that each of these is specific about what it does.
createItem() will only create an item if it doesn't already exist. It will return false it does. Likewise, updateItem() require an existing
item. Obviously so does readItem().

In addition to return a value indicating success or failure the property lastError is set with the return value of the underlying 
[KeyChain API](https://developer.apple.com/library/ios/documentation/Security/Reference/keychainservices/)

### KeyChainItem

For a lot of intents and purposes it's irrelevent when saving an item whether this is creating it or updating it. Likewise deleting
a non-existant item doesn't usually matter. If this is the case then use these higher level methods. Initially create an instance of KeyChainItemKey

let item = KeyChainItem(bundleId: NSBundle.mainBundle().bundleIdentifier!, keyChainItemKey: "something")

then the methods

- load() -> NSData?
- save(data: NSData) -> Bool

or ideally if the item that needs loading/saving is NSCoding compliant:

- load<T: NSCoding>() -> T?
- save<T: NSCoding>(t: T) -> Bool

### General

Multiple items can be CRUDed but as each will require a different key then different instances will be required.

## Installation

The minimum target is iOS 8. The source code could be copied into a separate project but it is packaged as Framework

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'KeyChainItemCRUDKit', '~> 0.0.2'
```

Then, run the following command:

```bash
$ pod install
```

## Example

An example application is included. It follows the CocoaPods standard of being called Example. It's a simple SingleView applications that allows a single item to be created, read, updated & deleted. It uses the higher level object interface.

## Tests

Unit tests for both the CRUD and high level interface are provided.