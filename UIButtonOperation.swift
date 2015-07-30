//
//  UIButtonOperation.swift
//  CalculatriceSwift
//
//  Created by François Juteau on 29/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

import Foundation
import UIKit

/// A class that inherits from UIButton to add a methode that will depend on the selected button
class UIButtonOperation:UIButton
{
    /// Function not defined until the setter
    var fonction:((Double,Double)->Double)?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    /**
    Sets the function to this UIButton
    
    :param: fonc function
    */
    func setFonctionOperation(fonc:(Double, Double)->Double)
    {
        fonction = fonc
    }
    
    /**
    Execute the function setted for the current UIButton
    
    :param: _op1 first operand
    :param: _op2 second operand
    
    :returns: result of the operation
    */
    func doOperation(_op1:Double, _op2:Double)->Double
    {
        return fonction!(_op1, _op2)
    }
}