//
//  ViewController.swift
//  Example
//
//  Created by Pete on 06/06/2015.
//  Copyright (c) 2015 KeyChainItemCRUDKit. All rights reserved.
//

import UIKit
import KeyChainItemCRUDKit

class ViewController: UIViewController
{

	@IBOutlet weak var label: UILabel!
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		label.text = KeyChainItemCRUD().f("world")
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

