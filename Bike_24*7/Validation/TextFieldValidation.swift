//
//  TextFieldValidation.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/14/22.
//

import UIKit

class TextFieldValidation: NSObject {

    //MARK: Name Validation
    class func nameValidation(_ name: String) -> Bool {
        
        let nameRegx = "[A-Za-z ]{4,}"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegx)
        return namePred.evaluate(with: name)
    }
    
    //MARK: Email ID Validation
    class func emailValidation(_ email: String) -> Bool {
        
        let emailRegx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: Mobile Number Validation
    class func mobileValidation(_ mobile: String) -> Bool {
        
        let mobileRegx = "[0-9]{10,10}"
        let mobilePred = NSPredicate(format: "SELF MATCHES %@", mobileRegx)
        return mobilePred.evaluate(with: mobile)
    }
    
    //MARK: Password Validation
    class func passwordValidation(_ password: String) -> Bool {
        
        let passwordRegx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%&?._-]).{6,}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        return passwordPred.evaluate(with: password)
    }
    
    //MARK: Confirm password validation
    class func confirmPasswordValidation(_ password: String, _ confirmPassword: String) -> Bool {
        
        if ((password == confirmPassword) && (passwordValidation(password))) {
            return true
        }
        return false
    }
    
}
