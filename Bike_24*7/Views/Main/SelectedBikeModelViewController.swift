//
//  SelectedBikeModelViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/7/22.
//

import UIKit
import Alamofire

class SelectedBikeModelViewController: UIViewController {
    
    @IBOutlet weak var modelImageView: UIImageView!
    
    @IBOutlet weak var modelBrandLabel: UILabel!
    @IBOutlet weak var modelNameLabel: UILabel!
    
    @IBOutlet weak var modelTypeLabel: UILabel!
    @IBOutlet weak var modelPriceLabel: UILabel!
    @IBOutlet weak var modelDescriptionLabel: UILabel!
    @IBOutlet weak var favouriteIcon: UIImageView!
    
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
        modelNameLabel.text = modelName
        modelTypeLabel.text = modelType
        modelBrandLabel.text = modelBrand
        modelDescriptionLabel.text = modelDescription
        modelPriceLabel.text = modelPrice
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
            favouriteIcon.image = UIImage(named: "redFill.jpg")
        }
        else {
            favouriteIcon.image = UIImage(named: "blackHeart.png")
        }
    }
    
    @IBAction func selectedBikeModelBackButtonClicked(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func orderNowButtonClicked(_ sender: Any) {
        let orderViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        self.navigationController?.pushViewController(orderViewController, animated: true)
        guard let cUser = user else {return}
        DBOperations.dbOperationInstance().insertDataToOrderList(mName: modelName, mBrand: modelBrand, mImage: modelImage, mPrice: modelPrice, mUser: cUser)
    }
    
    
    @IBAction func tappedOnFavoriteIcon(_ sender: Any) {
        favouriteIcon.image = UIImage(named: "redFill.jpg")
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
