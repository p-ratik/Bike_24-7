//
//  AboutUsViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/14/22.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func aboutUsButtonClicked(_ sender: Any) {
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
