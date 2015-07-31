//
//  ViewController.swift
//  CalculatriceSwift
//
//  Created by François Juteau on 28/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    /// First operand in NSString
    var operand1:NSString = ""
    /// Second operand in NSString
    var operand2:NSString = ""
    
    /// Result in double
    var result:Double = 0
    /// UIButtonOperation cache that will keep the next operation that will be used
    var nextOperation:UIButtonOperation?
    
    /// Label outlet
    @IBOutlet weak var label: UILabel!
    
    // Operations button outlet
    @IBOutlet weak var buttonPlus: UIButtonOperation!
    @IBOutlet weak var buttonMoins: UIButtonOperation!
    @IBOutlet weak var buttonMulti: UIButtonOperation!
    @IBOutlet weak var buttonDiv: UIButtonOperation!
    @IBOutlet weak var buttonEqual: UIButtonOperation!
    
    ///  An array that will stock all the memory buttons
    var memoryArray:NSMutableArray
    /// The number of memory currently displayed
    var nbCurrentMemory:Int
    
    // Memory buttons
    @IBOutlet weak var memory1: UIButton!
    @IBOutlet weak var memory2: UIButton!
    @IBOutlet weak var memory3: UIButton!
    @IBOutlet weak var memory4: UIButton!
    @IBOutlet weak var memory5: UIButton!
    
    // MARK: - Controller inner methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Assinging every memory buttons to the buttons array
        memoryArray.addObject(memory1)
        memoryArray.addObject(memory2)
        memoryArray.addObject(memory3)
        memoryArray.addObject(memory4)
        memoryArray.addObject(memory5)
        
        // Adding each fonction used on operations buttons
        buttonPlus.setFonctionOperation(doPlusOperation)
        buttonMoins.setFonctionOperation(doMoinsOperation)
        buttonMulti.setFonctionOperation(doMultiOperation)
        buttonDiv.setFonctionOperation(doDivOperation)
        buttonEqual.setFonctionOperation(doEqualOperation)
        
        // Swipe gesture regognizer declaration to delete a character
        var swipe:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: ("handleSwipeLeftGesture"))
        swipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(swipe)
        
        reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Inits and resets
    
    // Init override
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
    
    // MARK: - Actions on the view
    
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
        // Exception : an operation button can be pressed after equal button
        if (nextOperation?.selected != true || nextOperation == buttonEqual)
        {
            operand2 = label.text!
            
            if (( nextOperation ) != nil)
            {
                // Use of the method affected on each UIButtonOperation
                handleErrorMessage(nextOperation!.doOperation(operand1.doubleValue, _op2: operand2.doubleValue, _result:&result))
            }
            else
            {
                // Exemple of use atof that casts a string into a double
                result = atof(operand2.description)
            }
            
            // Set false only used for the buttonEqual case
            nextOperation?.selected = false
            
            nextOperation = sender
            
            operand1 = result.description
            label.text = String(operand1)
            
            nextOperation?.selected = true
        }
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
        label.text = (atof(label.text!) * -1).description
    }
    
    /**
    Shift memories down and sets the first one to the label text
    
    :param: sender not used
    */
    @IBAction func addMemory(sender: UIButton)
    {
        if (label.text != "")
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
            nextOperation?.selected = false
        }
    }
    
    // MARK: - Intern methods
    
    /**
    Adds or start a fresh digit depending on if an operation is selected or not
    
    :param: _value digit to add
    */
    func pushButtonWithInt(_value:String)
    {
        // If an operation is selected, we display only the next numeric button pressed
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
        label.text = label.text! + _digit
    }
    
    // MARK: - Handling methods
    
    /**
    Handle the displaying of an error message
    
    :param: _message mesage to display
    */
    func handleErrorMessage(_message:String)
    {
        println("MESSAGE ERROR : \(_message)")
            
        if ( _message != "")
        {
            var alert = UIAlertController(title: "Alert", message: _message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    /**
    Handle the left swipe gesture by deleting the last character on the label
    */
    func handleSwipeLeftGesture()
    {
        // Two ways to do it
//        label.text?.removeAtIndex(label.text!.endIndex.predecessor())
        
        if ( nextOperation?.selected == true || nextOperation == buttonEqual || label.text == "")
        {
            reset()
        }
        else
        {
            label.text = dropLast(label.text!)
        }
    }
    
    // MARK: - Methods used in UIButtonOperation
    
    func doPlusOperation(_op1:Double, _op2:Double, inout _result:Double)->String
    {
        _result = _op1 + _op2
        return ""
    }
    
    func doMoinsOperation(_op1:Double, _op2:Double, inout _result:Double)->String
    {
        _result = _op1 - _op2
        return ""
    }
    
    func doMultiOperation(_op1:Double, _op2:Double, inout _result:Double)->String
    {
        _result = _op1 * _op2
        return ""
    }
    
    func doDivOperation(_op1:Double, _op2:Double, inout _result:Double)->String
    {
        if (Float(_op2) != 0.0)
        {
            _result = _op1 / _op2
            return ""
        }
        else
        {
            // Case when divided by 0
            return "Indivisible par 0"
        }
    }
    
    func doEqualOperation(_op1:Double, _op2:Double, inout _result:Double)->String
    {
        _result = atof(label.text!)
        return ""
    }
    
}

