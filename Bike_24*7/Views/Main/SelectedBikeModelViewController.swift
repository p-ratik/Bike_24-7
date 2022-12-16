//
//  SelectedBikeModelViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/7/22.
//

import UIKit
import Alamofire

class SelectedBikeModelViewController: UIViewController {
    
    //MARK: Outlets for SelectedBikeModelViewController Page
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var modelBrandLabel: UILabel!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var modelTypeLabel: UILabel!
    @IBOutlet weak var modelPriceLabel: UILabel!
    @IBOutlet weak var modelDescriptionLabel: UILabel!
    @IBOutlet weak var favouriteIcon: UIImageView!
    @IBOutlet weak var selectedBikeOrderButtonOutlet: UIButton!
    @IBOutlet weak var selectedBikeTitle: UILabel!
    
    var modelName = ""
    var modelType = ""
    var modelDescription = ""
    var modelPrice = ""
    var modelBrand = ""
    var modelImage = ""
    var user: User?
    var ifFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //MARK: Assigning model data to label text
        modelNameLabel.text = modelName
        modelTypeLabel.text = modelType
        modelBrandLabel.text = modelBrand
        modelDescriptionLabel.text = modelDescription
        modelPriceLabel.text = modelPrice
        selectedBikeTitle.text = modelName
        Alamofire.request(modelImage).responseJSON(completionHandler: {response in
            self.modelImageView.image = UIImage(data: response.data!)
        })
        user = DBOperations.dbOperationInstance().fetchMatchedRecord(email: currentUser ?? "")
        if user?.toFavourites?.allObjects != nil {
            let models = user?.toFavourites?.allObjects as! [Favourites]
            for model in models {
                if (model.modelName == modelName) {
                    ifFavourite = true
                }
            }
        }
        if (ifFavourite) {
            favouriteIcon.image = UIImage(named: "selected 1.png")
        }
        else {
            favouriteIcon.image = UIImage(named: "notSelect 1.png")
        }
        selectedBikeOrderButtonOutlet.layer.cornerRadius = 10
    }
    
    @IBAction func selectedBikeModelBackButtonClicked(_ sender: Any) {
        let bikeModelViewController = self.storyboard?.instantiateViewController(withIdentifier: "BikeModelsViewController") as! BikeModelsViewController
        self.navigationController?.pushViewController(bikeModelViewController, animated: true)
        bikeModelViewController.fileName = modelBrand
    }

    @IBAction func orderNowButtonClicked(_ sender: Any) {
        guard let cUser = user else {return}
        DBOperations.dbOperationInstance().insertDataToOrderList(mName: modelName, mBrand: modelBrand, mImage: modelImage, mPrice: modelPrice, mUser: cUser)
        self.showOrderPlacedAlert(itemName: modelName, mssg: "Order Placed Successfully!", title: "Congratulations")
        let localNotificationObj = LocalNotificationClass()
        localNotificationObj.receiveNotification(itemName: modelName)
        
    }
    
    
    @IBAction func tappedOnFavoriteIcon(_ sender: Any) {
        favouriteIcon.image = UIImage(named: "selected 1.jpg")
        guard let cUser = user else {return}
        DBOperations.dbOperationInstance().insertDataToFavorite(mName: modelName, mBrand: modelBrand, mDesc: modelDescription, mPrice: modelPrice, mImage: modelImage, mType: modelType, mUser: cUser)
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

//MARK: Extension to UIViewController for Alert function
extension UIViewController {
        func showOrderPlacedAlert(itemName: String, mssg: String, title: String) {
        let alert = UIAlertController(title: title, message: itemName + "-" + mssg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) {
            _ in
            let customTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController")  as! UITabBarController
            self.navigationController?.pushViewController(customTabBarController, animated: true)
        })
        self.present(alert, animated: true)
    }
}
