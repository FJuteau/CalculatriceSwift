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
    var nextOperation:UIButton?
    
    @IBOutlet weak var label: UITextField!
    
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMoins: UIButton!
    @IBOutlet weak var buttonMulti: UIButton!
    @IBOutlet weak var buttonDiv: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    
    var memoryArray:NSMutableArray
    var nbCurrentMemory:Int
    
    @IBOutlet weak var memory1: UIButton!
    @IBOutlet weak var memory2: UIButton!
    @IBOutlet weak var memory3: UIButton!
    @IBOutlet weak var memory4: UIButton!
    @IBOutlet weak var memory5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        memoryArray.addObject(memory1)
        memoryArray.addObject(memory2)
        memoryArray.addObject(memory3)
        memoryArray.addObject(memory4)
        memoryArray.addObject(memory5)
        
        reset()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        nextOperation = nil
        nbCurrentMemory = 0
        memoryArray = NSMutableArray.new()
        
        super.init(coder: aDecoder)
    }
    
    func reset()
    {
        label.text = ""
        nextOperation?.selected = false
        
        nextOperation = nil
        operand1 = ""
        operand2 = ""
        result = 0
    }
    
    
    @IBAction func pushNumericButton(sender: UIButton)
    {
        pushButtonWithInt(String(sender.tag))
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
    
    /*!
    *  @author François Juteau
    *
    *  @brief  Methodes interne
    */
    
    func pushButtonWithInt(_value:String)
    {
        if ( nextOperation?.selected == true || nextOperation == buttonEqual)
        {
            label.text = _value
            nextOperation?.selected = false
        }
        else
        {
            addDigit(_value)
        }
    }
    
    func addDigit(_digit:String)
    {
        label.text = label.text + _digit
    }
}

