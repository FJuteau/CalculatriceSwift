//
//  ViewController.swift
//  CalculatriceSwift
//
//  Created by François Juteau on 28/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var operand1:NSString = ""
    var operand2:NSString = ""
    var result:Double = 0
    var nextOperation:UIButtonOperation?
    
    @IBOutlet weak var label: UITextField!
    
    @IBOutlet weak var buttonPlus: UIButtonOperation!
    @IBOutlet weak var buttonMoins: UIButtonOperation!
    @IBOutlet weak var buttonMulti: UIButtonOperation!
    @IBOutlet weak var buttonDiv: UIButtonOperation!
    @IBOutlet weak var buttonEqual: UIButtonOperation!
    
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
        
        buttonPlus.setFonctionOperation(doPlusOperation)
        buttonMoins.setFonctionOperation(doMoinsOperation)
        buttonMulti.setFonctionOperation(doMultiOperation)
        buttonDiv.setFonctionOperation(doDivOperation)
        buttonEqual.setFonctionOperation(doEqualOperation)
        
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
    
    /**
    Reset all operations properties
    */
    func reset()
    {
        label.text = ""
        nextOperation?.selected = false
        
        nextOperation = nil
        operand1 = ""
        operand2 = ""
        result = 0
    }
    
    /**
    Handle the adding of digits on the label text
    
    :param: sender UIButton that is pressed
    */
    @IBAction func pushNumericButton(sender: UIButton)
    {
        pushButtonWithInt(String(sender.tag))
    }
    
    /**
    Applies the last operation to the operands and sets the next operation
    
    :param: sender UIButtonOperation of the last operation pressed
    */
    @IBAction func pushOperationButton(sender: UIButtonOperation)
    {
        operand2 = label.text
        
        if (( nextOperation ) != nil)
        {
            result = nextOperation!.doOperation(operand1.doubleValue, _op2: operand2.doubleValue)
        }
        else
        {
            // Exemple of use atof that casts a string into a double
            result = atof(operand2.description)
        }
        
        nextOperation?.selected = false
        nextOperation = sender
        
        operand1 = result.description
        label.text = String(operand1)
        nextOperation?.selected = true
        
    }
    
    /**
    Resets operations properties
    
    :param: sender not used
    */
    @IBAction func pushCancelButton(sender: UIButton)
    {
        reset()
    }
    
    /**
    Adds a comma at the end of the label
    
    :param: sender not used
    */
    @IBAction func pushCommaButton(sender: UIButton)
    {
        pushButtonWithInt(".")
    }
    
    /**
    Change the sign of the label
    
    :param: sender not used
    */
    @IBAction func pushNegativeButton(sender: UIButton)
    {
        label.text = "-" + label.text
    }
    
    /**
    Shift memories down and sets the first one to the label text
    
    :param: sender not used
    */
    @IBAction func addMemory(sender: UIButton)
    {
        var i:Int = nbCurrentMemory
        
        while ( i > 0 )
        {
            (memoryArray[i] as! UIButton).setTitle((memoryArray[i-1] as! UIButton).titleLabel!.text, forState: UIControlState.Normal)
            
            (memoryArray[i] as! UIButton).hidden = false
            i--
        }
        
        (memoryArray[0] as! UIButton).setTitle(label.text, forState: UIControlState.Normal)
        (memoryArray[0] as! UIButton).hidden = false
        
        if ( nbCurrentMemory < memoryArray.count-1)
        {
            nbCurrentMemory++
        }
        
    }
    
    /**
    Set the label to the UIButton text if it's not empty
    
    :param: sender a memory button that was pressed
    */
    @IBAction func memoryAccess(sender: UIButton)
    {
        if ( sender.titleLabel!.text != "")
        {
            label.text = sender.titleLabel?.text
        }
    }
    
    /**
    Adds or start a fresh digit depending on if an operation is selected or not
    
    :param: _value digit to add
    */
    func pushButtonWithInt(_value:String)
    {
        if ( nextOperation?.selected == true )
        {
            label.text = _value
            nextOperation?.selected = false
        }
        else
        {
            addDigit(_value)
        }
    }
    
    /**
    Adds a digit to existants digits in label
    
    :param: _digit digit to add
    */
    func addDigit(_digit:String)
    {
        label.text = label.text + _digit
    }
    
    
    // MARK: - Methodes used in UIButtonOperation
    
    func doPlusOperation(_op1:Double, _op2:Double)->Double
    {
        return _op1 + _op2
    }
    
    func doMoinsOperation(_op1:Double, _op2:Double)->Double
    {
        return _op1 - _op2
    }
    
    func doMultiOperation(_op1:Double, _op2:Double)->Double
    {
        return _op1 * _op2
    }
    
    func doDivOperation(_op1:Double, _op2:Double)->Double
    {
        if (Float(_op2) != 0.0)
        {
            return _op1 / _op2
        }
        else
        {
            return Double(0)
        }
    }
    
    func doEqualOperation(_op1:Double, _op2:Double)->Double
    {
        return _op1
    }
    
    
}

