//
//  OrderViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/7/22.
//

import UIKit
import Alamofire

class OrderTableViewCell: UITableViewCell {
    
    //MARK: Outlets for OrderTableViewCell Outlets
    @IBOutlet weak var orderedModelNameLabel: UILabel!
    @IBOutlet weak var orderedModelBrandLabel: UILabel!
    @IBOutlet weak var orderedModelPriceLabel: UILabel!
    @IBOutlet weak var modelImageView: UIImageView!
}

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderTableView: UITableView!
    var modelName = ""
    var modelBrand = ""
    var modelPrice = ""
    var modelImage = ""
    var orderBikes: [Order] = []
    var profile = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = DBOperations.dbOperationInstance().fetchMatchedRecord(email: currentUser ?? "")
        if user?.toOrder?.allObjects != nil {
            orderBikes = user?.toOrder?.allObjects as! [Order]
        }
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.reloadData()
    }
    
   
    //MARK: orderTableView datasource and delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderBikes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        cell.orderedModelNameLabel.text = orderBikes[indexPath.row].modelName
        let brand = orderBikes[indexPath.row].modelBrand!
        cell.orderedModelBrandLabel.text = "Brand: \(brand)"
        let price = orderBikes[indexPath.row].modelPrice!
        cell.orderedModelPriceLabel.text = "Price: \(price)"
        let image = orderBikes[indexPath.row].modelImage!
        Alamofire.request(image).responseJSON(completionHandler: {response in
            cell.modelImageView.image = UIImage(data: response.data!)
        })
//        cell.layer.borderWidth = 0.5
        return cell
    }
    

   
    @IBAction func orderBackButtonClicked(_ sender: Any) {
        if (profile) {
            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")  as! ProfileViewController
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        else {
            let customTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController")  as! UITabBarController
            self.navigationController?.pushViewController(customTabBarController, animated: true)
        }
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
