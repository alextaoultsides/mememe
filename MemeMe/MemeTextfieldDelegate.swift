//
//  MemeTextfieldDelegate.swift
//  MemeMe
//
//  Created by atao1 on 12/18/17.
//  Copyright © 2017 atao1. All rights reserved.
//

import Foundation
import UIKit

class MemeTextfieldDelegate: NSObject, UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
