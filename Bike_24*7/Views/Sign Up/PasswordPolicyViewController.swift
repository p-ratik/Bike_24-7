//
//  PasswordPolicyViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/18/22.
//

import UIKit

class PasswordPolicyViewController: UIViewController {
    
    //MARK: Outlet Connection
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        
    }

    //MARK: Dismissing view
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
