//
//  FavoriteViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/7/22.
//

import UIKit
import Alamofire

class FavoriteModelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var modelDescription: UILabel!
    @IBOutlet weak var modelPrice: UILabel!
    @IBOutlet weak var orderButoon: UIButton!    
    @IBOutlet weak var addToFavouriteIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var favouriteModelCollectionView: UICollectionView!
    
    var models: [Favourites] = []
    var user: User?
    var profile = false
    var currModelName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = DBOperations.dbOperationInstance().fetchMatchedRecord(email: currentUser ?? "")
        if user?.toFavourites?.allObjects != nil {
            models = user?.toFavourites?.allObjects as! [Favourites]
        }
        favouriteModelCollectionView.delegate = self
        favouriteModelCollectionView.dataSource = self
        favouriteModelCollectionView.delegate = self
        
        favouriteModelCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    
    //MARK: Favourite collection view datasource and delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favouriteModelCollectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCell", for: indexPath) as! FavoriteModelCollectionViewCell
        cell.modelName.text = models[indexPath.row].modelName
        cell.modelPrice.text = models[indexPath.row].modelPrice
        cell.modelDescription.text = models[indexPath.row].modelDescription
        let mImage = models[indexPath.row].modelImage ?? ""
        Alamofire.request(mImage).responseJSON(completionHandler: {response in
            cell.modelImage.image = UIImage(data: response.data!)
        })
        cell.orderButoon.tag = indexPath.row
        cell.orderButoon.addTarget(self, action: #selector(orderButtonClicked), for: .touchUpInside)
        cell.layer.borderWidth = 0.2
        cell.orderButoon.layer.cornerRadius = 10
        cell.layer.cornerRadius = 5
        cell.addToFavouriteIcon.tag = indexPath.row
        cell.addToFavouriteIcon.addTarget(self, action: #selector(addToFavouriteIconClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 220)
    }
    
    //MARK: Objective-c function to place the order
    @objc func orderButtonClicked( sender: UIButton) {
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        let mName = models[indexpath1.row].modelName
        let mBrand = models[indexpath1.row].modelBrand
        let mImage = models[indexpath1.row].modelImage
        let mPrice = models[indexpath1.row].modelPrice
        guard let cUser = user else {return}
        self.showOrderPlacedAlert(itemName: mName ?? "", mssg: "Order Placed Successfully", title: "Congratulation")
        let localNotificationObj = LocalNotificationClass()
        localNotificationObj.receiveNotification(itemName: mName!)
        DBOperations.dbOperationInstance().insertDataToOrderList(mName: mName!, mBrand: mBrand!, mImage: mImage!, mPrice: mPrice!, mUser: cUser)
    }
    
    //MARK: Objective-c function to remove from favouriteList
    @objc func addToFavouriteIconClicked(sender: UIButton) {
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        let mName = models[indexpath1.row].modelName
        DBOperations.dbOperationInstance().deleteModelfromFavourite(mName: mName ?? "")
        models.remove(at: indexpath1.row)
        favouriteModelCollectionView.reloadData()
    }
    
    @IBAction func favouriteBackButtonClicked(_ sender: Any) {
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
