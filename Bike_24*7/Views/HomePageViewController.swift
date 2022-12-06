//
//  HomePageViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/16/22.
//

import UIKit
import Firebase

class HomePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutClicked(_ sender: Any) {
        
        do {
            //Signing out of firebase
            try Auth.auth().signOut()
            
            //Navigating back to login view
            self.navigationController?.popToRootViewController(animated: true)
        } catch(let error) {
            
            print(error.localizedDescription)
        }
    }

}
