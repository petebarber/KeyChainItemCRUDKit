import Foundation

public class KeyChainItemCRUD
{
	private let bundleId: String
	private let keyChainItemKey: String
	public private(set) var lastResult = errSecSuccess
	
	public init(bundleId: String, keyChainItemKey: String)
	{
		self.bundleId = bundleId
		self.keyChainItemKey = keyChainItemKey
	}
	
	public func createItem(data: NSData) -> Bool
	{
		let item = [
			kSecClass		as NSString : kSecClassGenericPassword,
			kSecAttrService	as NSString : bundleId,
			kSecAttrAccount as NSString : keyChainItemKey,
			kSecValueData	as NSString : data] as NSDictionary
		
		var result: Unmanaged<AnyObject>?
		
		lastResult = SecItemAdd(item, &result)
		
		return lastResult == errSecSuccess
	}
	
	public func readItem() -> NSData?
	{
		let keyChainItemQuery = [
			kSecClass				as NSString : kSecClassGenericPassword,
			kSecAttrService 		as NSString	: bundleId,
			kSecAttrAccount 		as NSString	: keyChainItemKey,
			kSecReturnData			as NSString	: kCFBooleanTrue] as NSDictionary
		
		var returnedData: Unmanaged<AnyObject>?
		
		lastResult = SecItemCopyMatching(keyChainItemQuery, &returnedData)
		
		if lastResult == errSecSuccess
		{
			return returnedData!.takeRetainedValue() as? NSData
		}
		
		return nil
	}
	
	public func updateItem(data: NSData) -> Bool
	{
		let query = [
			kSecClass		as NSString : kSecClassGenericPassword,
			kSecAttrService	as NSString : bundleId,
			kSecAttrAccount as NSString : keyChainItemKey] as NSDictionary
		
		let update = [kSecValueData	as NSString : data] as NSDictionary
		
		var result: Unmanaged<AnyObject>?
		
		lastResult = SecItemUpdate(query, update)
		
		return lastResult == errSecSuccess
	}
	
	public func deleteItem() -> Bool
	{
		let query = [
			kSecClass		as NSString : kSecClassGenericPassword,
			kSecAttrService	as NSString : bundleId,
			kSecAttrAccount as NSString : keyChainItemKey] as NSDictionary
		
		lastResult = SecItemDelete(query)
		
		return lastResult == errSecSuccess
	}
}

