//
//  ViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/14/22.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController {

    //MARK: Outlet Connection
    @IBOutlet weak var welcomeView: UIView!
    
    @IBOutlet weak var appImage: UIImageView!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordErrorMsg: UILabel!
    @IBOutlet weak var emailErrorMsg: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Welcome View
        welcomeView.layer.cornerRadius = 70
        
        //Imagviews for textfield logo
        let emailImageView = UIImageView()
        let passwordImageView = UIImageView()
        let emailIcon = UIImage(named: "email.png")
        let passwordIcon = UIImage(named: "password.png")
        emailImageView.image = emailIcon
        passwordImageView.image = passwordIcon
        passwordTextField.leftViewMode = .always
        usernameTextField.leftViewMode = .always
        
        usernameTextField.leftView = emailImageView
        passwordTextField.leftView = passwordImageView

        
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        //resetting text fields
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        //Text Field Border
        usernameTextField.layer.borderWidth = 0.2
        usernameTextField.layer.cornerRadius = 9
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 0.2
        passwordTextField.layer.cornerRadius = 9
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        
        //resetting error message
        emailErrorMsg.isHidden = true
        passwordErrorMsg.isHidden = true
    }
    
    //MARK: Username Text Field Validation
    
    //Validating email id when editing did end
    //MARK: Using Editing Did End
    @IBAction func usernameValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.emailValidation(usernameTextField.text!)) && !(usernameTextField.text!.isEmpty)) {
            
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            usernameTextField.layer.borderWidth = 1
            
            emailErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.isHidden = false
        }
    }
    
    //Checking if email id satisfy email rules
    //MARK: Using Editing Changed
    @IBAction func usernameCheck(_ sender: Any) {
        
        if (TextFieldValidation.emailValidation(usernameTextField.text!)){
            
            usernameTextField.layer.borderColor = UIColor.green.cgColor
            usernameTextField.layer.borderWidth = 1
            
            emailErrorMsg.isHidden = true
        }
    }
    

    //MARK: Credential Validation
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        // Checking if username text field is empty
        if (usernameTextField.text!.isEmpty) {
            
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            usernameTextField.layer.borderWidth = 1
            
            emailErrorMsg.text = "Please Enter Email ID"
            emailErrorMsg.isHidden = false

        }
        
        //Checking if username is valid
        else if !(TextFieldValidation.emailValidation(usernameTextField.text!)) {
            
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            usernameTextField.layer.borderWidth = 1
            
            emailErrorMsg.text = "Username should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.isHidden = false
        }
    
        
        //Checking if password text field is empty
        if (passwordTextField.text!.isEmpty) {
            
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1
            
            passwordErrorMsg.text = "Please Enter Password"
            passwordErrorMsg.isHidden = false
            
        }
        
        //Firebase authentication
        if(emailErrorMsg.isHidden && passwordErrorMsg.isHidden) {
            
            //MARK: Sign In using Firebase
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!, completion: {(result, error) -> Void in
                
                if error == nil {
                    
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController")
                    self.navigationController?.pushViewController(home!, animated: true)
                }
                else {
                    
                    if let errorCode = error as NSError? {
                        
                        switch errorCode.code {
                            
                        case 17009:
                            self.alert("Password Does Not Match")
                        case 17011:
                            self.alert("Incorrect Email ID Or Password. \n If Don't have an account.\n Please Sign Up.")
                        default:
                            print("Something else happened.")
                        }
                    }
                }
            })
        }
    }
    
    //MARK: Sign Up
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    //MARK: Back Segue
    // Coming Back to Login View
    @IBAction func backToLoginPressed(_ segue: UIStoryboardSegue) {

    }
}

extension LoginViewController {
    
    //MARK: Alert Action
    func alert(_ msg: String) {
        let alertBox = UIAlertController(title: "Login Error!", message: msg, preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Okay", style: .destructive))
        self.parent?.present(alertBox, animated: true, completion: nil)
    }
}

