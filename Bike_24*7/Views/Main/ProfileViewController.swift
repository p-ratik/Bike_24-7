//
//  MenuViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/14/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var profileMobileLabel: UILabel!
    @IBOutlet weak var yourWishlisButtonOutlet: UIButton!
    @IBOutlet weak var yourOrderButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        yourWishlisButtonOutlet.layer.cornerRadius = 10
        yourOrderButtonOutlet.layer.cornerRadius = 10
        guard let user = DBOperations.dbOperationInstance().fetchMatchedRecord(email: currentUser!) else {return}
        profileNameLabel.text = "User Name:  \(user.name ?? "")"
        profileEmailLabel.text = "User Email ID:   \(user.email ?? "")"
        profileMobileLabel.text = "User Mobile Number:  \(user.mobile ?? "")"
    }
    
    @IBAction func yourWishlistButtonClicked(_ sender: Any) {
      
        let wishlistVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        navigationController?.pushViewController(wishlistVC, animated: true)
        wishlistVC.profile = true
    }
    
    @IBAction func yourOrderButtonClicked(_ sender: Any) {
        let orderVC = storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        navigationController?.pushViewController(orderVC, animated: true)
        orderVC.profile = true
    }
    @IBAction func profileBackButtonClicked(_ sender: Any) {
        let customTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController")  as! UITabBarController
        self.navigationController?.pushViewController(customTabBarController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
