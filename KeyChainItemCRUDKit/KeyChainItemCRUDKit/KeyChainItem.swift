import Foundation

public class KeyChainItem : KeyChainItemCRUD
{
	public override init(bundleId: String, keyChainItemKey: String)
	{
		super.init(bundleId: bundleId, keyChainItemKey: keyChainItemKey);
	}
	
	public func load<T: NSCoding>() -> T?
	{
		if let data = load()
		{
			return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? T
		}
		
		return nil
	}
	
	public func load() -> NSData?
	{
		return readItem()
	}
	
	public func save<T: NSCoding>(t: T) -> Bool
	{
		return save(NSKeyedArchiver.archivedDataWithRootObject(t))
	}
	
	public func save(data: NSData) -> Bool
	{
		return updateItem(data) || createItem(data)
	}
	
	public func delete() -> Bool
	{
		if deleteItem() == false
		{
			if lastResult != errSecItemNotFound
			{
				return false
			}
		}
		
		return true
	}
}
