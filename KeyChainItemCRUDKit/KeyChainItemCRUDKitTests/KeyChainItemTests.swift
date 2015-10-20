import UIKit
import XCTest
import KeyChainItemCRUDKit

class TestType : NSObject, NSCoding
{
	let test: String
	
	required init?(coder decoder: NSCoder)
	{
		test = decoder.decodeObjectForKey("test") as! String
	}
	
	func encodeWithCoder(encoder: NSCoder)
	{
		encoder.encodeObject(test, forKey: "test")
	}
	
	init(value: String)
	{
		self.test = value
		super.init()
	}
}

class KeyChainItemCRUDKitTests_KeyChainItem: XCTestCase
{
	private let bundleId = "bundleId"
	private let itemKey = "itemKey"
	private var test: KeyChainItem!
	
	override func setUp()
	{
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		test = KeyChainItem(bundleId: bundleId, keyChainItemKey: itemKey)
	}
	
	override func tearDown()
	{
		KeyChainItemCRUD(bundleId: bundleId, keyChainItemKey: itemKey).deleteItem()
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		
		super.tearDown()
	}
	
	func test_GivenNoItem_WhenLoaded_ThenFails()
	{
		let obj = test.load() as TestType?
		
		XCTAssertNil(obj, "Should be nil")
	}
	
	func test_GivenNoItem_WhenSaved_ThenSucceeds()
	{
		let obj = TestType(value: "123")
		
		XCTAssertTrue(test.save(obj), "save failed")
	}
	
	func test_GivenItem_WhenSaved_ThenSucceeds()
	{
		let obj = TestType(value: "123")
		
		XCTAssertTrue(test.save(obj), "save failed")
		XCTAssertTrue(test.save(obj), "save failed")
	}
	
	func test_GivenItem_WhenSavedWithDifferentValue_ThenIsUpdated()
	{
		var obj = TestType(value: "123")
		
		XCTAssertTrue(test.save(obj), "save failed")
		obj = TestType(value: "456")
		XCTAssertTrue(test.save(obj), "save failed")
		
		var readObj = test.load() as TestType?
		XCTAssertNotNil(readObj, "Item expected")
		XCTAssertEqual(readObj!.test, "456", "456 expected")
	}
	
	func test_GivenNoItem_WhenDeleted_ThenSucceeds()
	{
		XCTAssertTrue(test.delete(), "Shouldn't have deleted anything")
	}
	
	func test_GivenItem_WhenDeleted_ThenSucceeds()
	{
		var obj = TestType(value: "123")
		
		XCTAssertTrue(test.save(obj), "save failed")
		
		XCTAssertTrue(test.delete(), "Shouldn't have deleted anything")
		XCTAssertNil(test.load() as TestType?, "Shouldn't be anything there")
	}
}
