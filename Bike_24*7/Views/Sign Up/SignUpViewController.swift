//
//  SignUpViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/14/22.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    
    
    //MARK: Outlet Connection
    
    @IBOutlet weak var signUpImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBOutlet weak var nameErrorMsg: UILabel!
    @IBOutlet weak var emailErrorMsg: UILabel!
    @IBOutlet weak var mobileErrorMsg: UILabel!
    @IBOutlet weak var passwordErrorView: UIStackView!
    @IBOutlet weak var passwordErrorMsg: UILabel!
    @IBOutlet weak var passwordInfo: UIButton!
    @IBOutlet weak var confirmPasswordErrorMsg: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    let passwordEyeImageView = UIImageView()
    let confirmPasswordEyeImageView = UIImageView()
    
    var passwordImageClicked = false
    var confirmPasswordImageClicked = false
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hiding eye buttons
        passwordEyeImageView.isHidden = true
        confirmPasswordEyeImageView.isHidden = true

        //Display Image
        signUpImage.layer.cornerRadius = signUpImage.frame.height / 2
        signUpImage.layer.borderColor = UIColor.blue.cgColor
        signUpImage.layer.borderWidth = 1
        
        // MARK: - ImageViews for TextField Icons starts
        let usernameImageView = UIImageView()
        let emailImageView = UIImageView()
        let mobileImageView = UIImageView()
        let passwordImageView = UIImageView()
        let confirmPasswordImageView = UIImageView()
        
        // MARK: - ImageViews for TextField Icons starts
        
        // Setting Images to imageviews
        usernameImageView.image = UIImage(named: "user.png")
        emailImageView.image = UIImage(named: "email.png")
        mobileImageView.image = UIImage(named: "phone.png")
        passwordImageView.image = UIImage(named: "password.png")
        confirmPasswordImageView.image = UIImage(named: "ConfirmPassword.png")
        passwordEyeImageView.image = UIImage(named: "eye.png")
        confirmPasswordEyeImageView.image = UIImage(named: "eye.png")
        
        
        let contentViewPassword = UIView()
        let contentViewConfirmPassword = UIView()
        
        contentViewPassword.addSubview(passwordEyeImageView)
        contentViewConfirmPassword.addSubview(confirmPasswordEyeImageView)
        
        contentViewPassword.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eye.png")!.size.width, height: UIImage(named: "eye.png")!.size.height)
        passwordEyeImageView.frame = CGRect(x: -10, y: 0, width: UIImage(named: "eye.png")!.size.width, height: UIImage(named: "eye.png")!.size.height)
        
        contentViewConfirmPassword.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eye.png")!.size.width, height: UIImage(named: "eye.png")!.size.height)
        confirmPasswordEyeImageView.frame = CGRect(x: -10, y: 0, width: UIImage(named: "eye.png")!.size.width, height: UIImage(named: "eye.png")!.size.height)
        
        
        
        
        // Settign Properties ti textfields
        nameTextField.leftViewMode = .always
        emailTextField.leftViewMode = .always
        mobileTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
        passwordTextField.rightViewMode = .always
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.rightViewMode = .always
        
        nameTextField.leftView = usernameImageView
        emailTextField.leftView = emailImageView
        mobileTextField.leftView = mobileImageView
        passwordTextField.leftView = passwordImageView
        confirmPasswordTextField.leftView = confirmPasswordImageView
        passwordTextField.rightView = contentViewPassword
        confirmPasswordTextField.rightView = contentViewConfirmPassword
        
        let tapGestureRecognizerPassword = UITapGestureRecognizer(target: self, action: #selector(passwordEyeClicked(tapGestureRecognizer:)))
        passwordEyeImageView.isUserInteractionEnabled = true
        passwordEyeImageView.addGestureRecognizer(tapGestureRecognizerPassword)
        
        let tapGestureRecognizerConfirmPassword = UITapGestureRecognizer(target: self, action: #selector(ConfirmpasswordEyeClicked(tapGestureRecognizer:)))
        confirmPasswordEyeImageView.isUserInteractionEnabled = true
        confirmPasswordEyeImageView.addGestureRecognizer(tapGestureRecognizerConfirmPassword)
        
    }
    
    @objc func passwordEyeClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if passwordImageClicked {
            passwordImageClicked = false
            tappedImage.image = UIImage(named: "eye.png")
            passwordTextField.isSecureTextEntry = true
        }
        else
        {
            passwordImageClicked = true
            tappedImage.image = UIImage(named: "hide.png")
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    @objc func ConfirmpasswordEyeClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if confirmPasswordImageClicked {
            confirmPasswordImageClicked = false
            tappedImage.image = UIImage(named: "eye.png")
            confirmPasswordTextField.isSecureTextEntry = true
        }
        else
        {
            confirmPasswordImageClicked = true
            tappedImage.image = UIImage(named: "hide.png")
            confirmPasswordTextField.isSecureTextEntry = false
        }
    }
    
    //MARK: View will appear
    override func viewWillAppear(_ animated: Bool) {
        
        //Text Field Border
        nameTextField.layer.borderWidth = 0.2
        emailTextField.layer.borderWidth = 0.2
        mobileTextField.layer.borderWidth = 0.2
        passwordTextField.layer.borderWidth = 0.2
        confirmPasswordTextField.layer.borderWidth = 0.2
        
        nameTextField.layer.cornerRadius = 9
        emailTextField.layer.cornerRadius = 9
        mobileTextField.layer.cornerRadius = 9
        passwordTextField.layer.cornerRadius = 9
        confirmPasswordTextField.layer.cornerRadius = 9
        
        nameTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderColor = UIColor.black.cgColor
        mobileTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    //MARK: Name Text Field Validation
    
    //Validating name text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func nameValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.nameValidation(nameTextField.text!)) &&  !(nameTextField.text!.isEmpty)) {
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1
            
            nameErrorMsg.text = "Name should be valid (i.e. Atleast 4 characters)"
            nameErrorMsg.isHidden = false
        }
    }
    
    //Checking name text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func nameCheck(_ sender: Any) {
        
        if (TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            nameTextField.layer.borderColor = UIColor.green.cgColor
            nameTextField.layer.borderWidth = 1
            
            nameErrorMsg.isHidden = true
        }
    }
    
    //MARK: Email Text Field Validation
    
    
    //Validating email text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func emailValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.emailValidation(emailTextField.text!)) && !(emailTextField.text!.isEmpty)) {
            
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1
            
            emailErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.textColor = .systemRed
            emailErrorMsg.isHidden = false
        }
    }
    
    //Checking email text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func emailCheck(_ sender: Any) {
        
        if (TextFieldValidation.emailValidation(emailTextField.text!)) {
            
            emailTextField.layer.borderColor = UIColor.green.cgColor
            emailTextField.layer.borderWidth = 1
            
            emailErrorMsg.isHidden = true
        }
    }
    
    //MARK: Mobile Text Field Validation
    
    //Validating mobile text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func mobileValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.mobileValidation(mobileTextField.text!)) && !(mobileTextField.text!.isEmpty)) {
            
            mobileTextField.layer.borderColor = UIColor.red.cgColor
            mobileTextField.layer.borderWidth = 1
            
            mobileErrorMsg.text = "Mobile Number should be 10 digit number. E.g. 1234567890"
            mobileErrorMsg.textColor = .systemRed
            mobileErrorMsg.isHidden = false
        }
    }
    
    //Checking mobile text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func mobileCheck(_ sender: Any) {
        
        if (TextFieldValidation.mobileValidation(mobileTextField.text!)) {
            
            mobileTextField.layer.borderColor = UIColor.green.cgColor
            mobileTextField.layer.borderWidth = 1
            
            mobileErrorMsg.isHidden = true
        }
    }
    
    //MARK: Password Text Field Validation
    
    //Validating password text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func passwordValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.passwordValidation(passwordTextField.text!)) && !(passwordTextField.text!.isEmpty)) {
            
            passwordErrorView.isHidden = false
            
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1
            
            passwordErrorMsg.text =  "Password must follow policy rules."
            passwordErrorMsg.textColor = .systemRed
            passwordErrorMsg.isHidden = false
        }
    }
    
    //Checking password text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func passwordCheck(_ sender: Any) {
        
        passwordEyeImageView.isHidden = false
        if (TextFieldValidation.passwordValidation(passwordTextField.text!)) {
            
            passwordTextField.layer.borderColor = UIColor.green.cgColor
            passwordTextField.layer.borderWidth = 1

            passwordErrorMsg.isHidden = true
            
            passwordErrorView.isHidden = true
        }
    }
    
    //Displaying password Policy
    @IBAction func displayPolicy(_ sender: Any) {
        
        let passwordVC = self.storyboard?.instantiateViewController(withIdentifier: "PasswordPolicyViewController") as! PasswordPolicyViewController
        passwordVC.modalPresentationStyle = .overCurrentContext
        passwordVC.modalTransitionStyle = .crossDissolve
        self.present(passwordVC, animated: true, completion: nil)
        
    }
    
    
    //MARK: Confirm Password Text Field Validation
    
    
    //Validating confirm password text field when editing did end
    //MARK: Using Editing Did End
    @IBAction func confirmPasswordValidation(_ sender: Any) {
        
        if (!(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) && !(confirmPasswordTextField.text!.isEmpty)) {
            
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderWidth = 1
            
            confirmPasswordErrorMsg.text = "Should be same as password"
            confirmPasswordErrorMsg.textColor = .systemRed
            confirmPasswordErrorMsg.isHidden = false
        }
    }
    
    //Checking confirm password text field while editing changed
    //MARK: Using Editing Changed
    @IBAction func confirmPasswordCheck(_ sender: Any) {
        confirmPasswordEyeImageView.isHidden = false
        
        if (TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) {
            
            confirmPasswordTextField.layer.borderColor = UIColor.green.cgColor
            confirmPasswordTextField.layer.borderWidth = 1
            
            confirmPasswordErrorMsg.isHidden = true
        }
    }
    
    //MARK: Credential Validation
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        // Checking Name Text Field is empty
        if (nameTextField.text!.isEmpty) {
            
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1
            
            nameErrorMsg.text = "Please Enter Name"
            nameErrorMsg.isHidden = false
        }
        
        //Checking if name is valid
        else if !(TextFieldValidation.nameValidation(nameTextField.text!)) {
            
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1
            
            nameErrorMsg.text = "Name should be valid (i.e. Atleast 4 characters)"
            nameErrorMsg.isHidden = false
        }
                
        // Checking Email ID Text Field is empty
        if (emailTextField.text!.isEmpty) {
            
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1
            
            emailErrorMsg.text = "Please Enter Email ID"
            emailErrorMsg.isHidden = false
        }
        
        //Checking if email id is valid
        else if !(TextFieldValidation.emailValidation(emailTextField.text!)){
            
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1
            
            emailErrorMsg.text = "Email ID should be in valid Format. E.g. abc@domain.com"
            emailErrorMsg.textColor = .systemRed
            emailErrorMsg.isHidden = false
        }
        
        // Checking Mobile Text Field is empty
        if (mobileTextField.text!.isEmpty) {
            
            mobileTextField.layer.borderColor = UIColor.red.cgColor
            mobileTextField.layer.borderWidth = 1
            
            mobileErrorMsg.text = "Please Enter Mobile"
            mobileErrorMsg.isHidden = false
        }
        
        //Checking if mobile is valid
        else if !(TextFieldValidation.mobileValidation(mobileTextField.text!)){
            
            mobileTextField.layer.borderColor = UIColor.red.cgColor
            mobileTextField.layer.borderWidth = 1
            
            mobileErrorMsg.text = "Mobile Number should be 10 digit number. E.g. 1234567890"
            mobileErrorMsg.textColor = .systemRed
            mobileErrorMsg.isHidden = false
        }
        
        // Checking Password Text Field is empty
        if (passwordTextField.text!.isEmpty) {
            
            passwordErrorView.isHidden = false
            
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1
            
            passwordErrorMsg.text = "Please Enter Password"
            passwordErrorMsg.textColor = .systemRed
            passwordErrorMsg.isHidden = false
        }
        
        //Checking if password is valid
        else if !(TextFieldValidation.passwordValidation(passwordTextField.text!)){
            
            passwordErrorView.isHidden = false
            
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1
            
            passwordErrorMsg.text =  "Password must follows policy"
            passwordErrorMsg.textColor = .systemRed
            passwordErrorMsg.isHidden = false
        }
                
        // Checking Confirm Password Text Field is empty
        if (confirmPasswordTextField.text!.isEmpty) {
            
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderWidth = 1
            
            confirmPasswordErrorMsg.text = "Please Enter Confirm Password"
            confirmPasswordErrorMsg.textColor = .systemRed
            confirmPasswordErrorMsg.isHidden = false
        }
        
        //Checking if confirm password is valid
        else if !(TextFieldValidation.confirmPasswordValidation(passwordTextField.text!, confirmPasswordTextField.text!)) {
            
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderWidth = 1
            
            confirmPasswordErrorMsg.text = "Should be same as password"
            confirmPasswordErrorMsg.textColor = .systemRed
            confirmPasswordErrorMsg.isHidden = false
        }
        
        // Storing Data If Valid
        if (nameErrorMsg.isHidden && emailErrorMsg.isHidden && mobileErrorMsg.isHidden && passwordErrorMsg.isHidden && confirmPasswordErrorMsg.isHidden)
        {
            
            //MARK: Creating user in firebase
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { [self](result, error) -> Void in
                
                if error == nil {
                    
                    //MARK: Storing data in core data
                    DBOperations.dbOperationInstance().insertDataToUser(name: nameTextField.text!, email: emailTextField.text!.lowercased(), mobile: mobileTextField.text!, password: passwordTextField.text!)
                    
                    //MARK: Success Alert
                    let successAlert = UIAlertController(title: "Sign Up Success!!", message: "User Created Successfully.", preferredStyle: .alert)
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController")
                    successAlert.view.tintColor = .systemGreen
                    successAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(action: UIAlertAction!) in self.navigationController?.pushViewController(home!, animated: true)}))
                    self.present(successAlert, animated: true, completion: nil)
                }
                else {
                    
                    if let errorCode = error as NSError? {
                        switch errorCode.code {
                        case 17007:
                            self.alert("Email Id Already In Use.")
                        default:
                            print("Some other error occured")
                        }
                    }
                }
            })
        }
    }
}

extension SignUpViewController {
    
    // MARK: Alert Action
    func alert(_ msg: String) {
        
        let alertBox = UIAlertController(title: "Sign Up Error!!", message: msg, preferredStyle: .alert)
        alertBox.addAction(UIAlertAction(title: "Okay", style: .destructive))
        self.parent?.present(alertBox, animated: true, completion: nil)
    }
}
