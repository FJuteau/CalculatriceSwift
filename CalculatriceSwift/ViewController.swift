//
//  ViewController.swift
//  CalculatriceSwift
//
//  Created by François Juteau on 28/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var operand1:String = ""
    var operand2:String = ""
    var result:Double = 0
    var nextOperation:UIButton
    var label:UITextField
    
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMoins: UIButton!
    @IBOutlet weak var buttonMulti: UIButton!
    @IBOutlet weak var buttonDiv: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    
    @IBOutlet weak var memory1: UIButton!
    @IBOutlet weak var memory2: UIButton!
    @IBOutlet weak var memory3: UIButton!
    @IBOutlet weak var memory4: UIButton!
    @IBOutlet weak var memory5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        nextOperation = UIButton.new()
        label = UITextField.new()
        
        super.init(coder: aDecoder)
    }
    
    func reset()
    {
        
    }
    
    
    @IBAction func pushNumericButton(sender: UIButton)
    {
        
    }
    
    @IBAction func pushOperationButton(sender: UIButton)
    {
        
    }
    
    @IBAction func pushEqualButton(sender: UIButton)
    {
        
    }
    
    @IBAction func pushCancelButton(sender: UIButton)
    {
        
    }
    
    @IBAction func pushCommaButton(sender: UIButton)
    {
        
    }
    
    @IBAction func pushNegativeButton(sender: UIButton)
    {
        
    }
    
    @IBAction func addMemory(sender: UIButton)
    {
        
    }
    
    @IBAction func memoryAccess(sender: UIButton)
    {
        
    }
    
    
}

