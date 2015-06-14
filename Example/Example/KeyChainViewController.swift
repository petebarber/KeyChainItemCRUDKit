import UIKit
import KeyChainItemCRUDKit

class KeyChainViewController: UIViewController
{
	@IBOutlet weak var text1: UITextField!
	@IBOutlet weak var status: UILabel!
	
	let bundleId = NSBundle.mainBundle().bundleIdentifier!
	let KEYCHAIN_ITEM_KEY = "FeedlyTokens"
	let keyChainItem: KeyChainItem
	
	var someData: SomeType = SomeType()
	{
		didSet
		{
			text1?.text = someData.textString1
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		self.keyChainItem = KeyChainItem(bundleId: bundleId, keyChainItemKey: KEYCHAIN_ITEM_KEY)
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func didEndOnExit(sender: UITextField)
	{
		println("didEndOnExit")
		
		someData.textString1 = sender.text
	}
	
	@IBAction func clear(sender: AnyObject)
	{
		someData = SomeType()
	}
	
	@IBAction func load(sender: AnyObject)
	{
		if let someData = keyChainItem.load() as SomeType?
		{
			self.someData = someData
			println("load, someData:\(self.someData.textString1)")
		}

		updateStatus("load")
	}
	
	@IBAction func save(sender: AnyObject)
	{
		println("save, someData:\(someData.textString1)")
		
		keyChainItem.save(someData)
		updateStatus("save")
	}
	
	@IBAction func deleteItem(sender: AnyObject)
	{
		keyChainItem.delete()
		updateStatus("delete")
	}
	
	private func updateStatus(operation: String)
	{
		let lastResultAsText: String
		
		switch (keyChainItem.lastResult)
		{
			case errSecSuccess:
				lastResultAsText = "success"
			case errSecItemNotFound:
				lastResultAsText = "Item not found"
			case errSecDuplicateItem:
				lastResultAsText = "Duplicate item"
			default:
				lastResultAsText = "unknown"
		}
		
		status.text = "\(operation), lastResult:\(lastResultAsText)"
	}
}

