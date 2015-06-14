import Foundation

class SomeType : NSObject, NSCoding
{
	var textString1 = "one"
	var textString2 = "two"
	
	required init(coder decoder: NSCoder)
	{
		textString1 = decoder.decodeObjectForKey("textString1") as! String
		textString2 = decoder.decodeObjectForKey("textString2") as! String
	}
	
	func encodeWithCoder(encoder: NSCoder)
	{
		encoder.encodeObject(textString1, forKey: "textString1")
		encoder.encodeObject(textString2, forKey: "textString2")
	}
	
	override init()
	{
		super.init()
	}
}
