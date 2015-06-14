import UIKit
import XCTest
import KeyChainItemCRUDKit

class KeyChainItemCRUDKitTests: XCTestCase
{
	private let bundleId = "bundleId"
	private let itemKey = "itemKey"
	private var test: KeyChainItemCRUD!
	
    override func setUp()
	{
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		test = KeyChainItemCRUD(bundleId: bundleId, keyChainItemKey: itemKey)
    }
    
    override func tearDown()
	{
		KeyChainItemCRUD(bundleId: bundleId, keyChainItemKey: itemKey).deleteItem()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		
        super.tearDown()
    }
	
	func test_GivenNoItem_When_CreateItem_Then_Succeeds()
	{
		XCTAssertTrue(test.createItem(NSData()), "item should not exist")
	}

	func test_GivenNoItem_When_CreateItemForSecondTime_Then_Fails()
	{
		XCTAssertTrue(test.createItem(NSData()), "item should not exist")
		XCTAssertFalse(test.createItem(NSData()), "item should exist")
	}
	
	func test_GivenNoItem_WhenRead_ThenFailsAndLastErrorIserrSecItemNotFound()
	{
		XCTAssertNil(test.readItem(), "item shouldn't be found")
		XCTAssertEqual(test.lastResult, errSecItemNotFound, "Wrong error code")
	}

	func test_GivenItem_WhenRead_ThenSucceeds()
	{
		XCTAssertTrue(test.createItem(NSData()), "item should not exist")
		XCTAssertNotNil(test.readItem(), "item should be found")
	}
	
	func test_GivenNoItem_WhenUpdated_ThenFails()
	{
		XCTAssertFalse(test.updateItem(NSData()), "item should not exist")
	}
	
	func test_GivenItem_WhenUpdated_ThenSucceeds()
	{
		XCTAssertTrue(test.createItem(NSData()), "createItem failed")
		XCTAssertTrue(test.updateItem(NSData()), "item should not exist")
	}

	func test_GivenItem_WhenUpdated_ThenSucceedsAndWhenReadIsAsExpected()
	{
		var data = NSKeyedArchiver.archivedDataWithRootObject("Hello")
		
		XCTAssertTrue(test.createItem(data), "createItem failed")
		
		data = NSKeyedArchiver.archivedDataWithRootObject("World")
		
		XCTAssertTrue(test.updateItem(data), "item should not exist")
		
		let readData = test.readItem()!
		let readString = NSKeyedUnarchiver.unarchiveObjectWithData(readData) as! String
		XCTAssertEqual(readString, "World", "Got \(readString) expected World")
	}
	
	func test_GivenNoItem_WhenDeleted_ThenFails()
	{
		XCTAssertFalse(test.deleteItem(), "Item should not exist")
	}
	
	func test_GivenItem_WhenDeleted_ThenSucceedsAndIsNotPresent()
	{
		XCTAssertTrue(test.createItem(NSData()), "createItem failed")
		XCTAssertTrue(test.deleteItem(), "Item should exist")
		XCTAssertFalse(test.deleteItem(), "Item should not exist")
	}
}
