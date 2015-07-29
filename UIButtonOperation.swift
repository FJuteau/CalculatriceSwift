//
//  UIButtonOperation.swift
//  CalculatriceSwift
//
//  Created by François Juteau on 29/07/2015.
//  Copyright (c) 2015 François Juteau. All rights reserved.
//

import Foundation
import UIKit

class UIButtonOperation:UIButton
{
    var fonction:((Double,Double)->Double)?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setFonctionOperation(fonc:(Double, Double)->Double)
    {
        fonction = fonc
    }
    
    func doOperation(_op1:Double, _op2:Double)->Double
    {
        return fonction!(_op1, _op2)
    }
}