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
    
    @IBAction func pushOperationButton(sender: UIButtonOperation)
    {
        operand2 = label.text
        
        if (( nextOperation ) != nil)
        {
            result = nextOperation!.doOperation(operand1.doubleValue, _op2: operand2.doubleValue)
        }
        else
        {
            result = operand2.doubleValue
        }
        
        nextOperation?.selected = false
        nextOperation = sender
        
        operand1 = result.description
        label.text = String(operand1)
        nextOperation?.selected = true
        
    }
    
    @IBAction func pushCancelButton(sender: UIButton)
    {
        reset()
    }
    
    @IBAction func pushCommaButton(sender: UIButton)
    {
        pushButtonWithInt(".")
    }
    
    @IBAction func pushNegativeButton(sender: UIButton)
    {
        label.text = "-" + label.text
    }
    
    @IBAction func addMemory(sender: UIButton)
    {
        var i:Int = nbCurrentMemory
        
        while ( i > 0 )
        {
//            (memoryArray[i] as! UIButton).titleLabel?.text = (memoryArray[i-1] as! UIButton).titleLabel!.text
            (memoryArray[i] as! UIButton).setTitle((memoryArray[i-1] as! UIButton).titleLabel!.text, forState: UIControlState.Normal)
            
            (memoryArray[i] as! UIButton).hidden = false
            i--
        }
        
//        var titleLabel:UILabel = (memoryArray[0] as! UIButton).titleLabel!
//        titleLabel.text = label.text
        (memoryArray[0] as! UIButton).setTitle(label.text, forState: UIControlState.Normal)
        (memoryArray[0] as! UIButton).hidden = false
        
        if ( nbCurrentMemory < memoryArray.count-1)
        {
            nbCurrentMemory++
        }
        
    }
    
    @IBAction func memoryAccess(sender: UIButton)
    {
        if ( sender.titleLabel!.text == "")
        {
            label.text = sender.titleLabel?.text
        }
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

