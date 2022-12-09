//
//  BikeModelsViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA161 on 12/7/22.
//

import UIKit
import Alamofire
class BikeModelsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var fileName = ""
    var searching = false
    var filteredBikeModels = [BikesData]()
    var user: User?
    var ifFavourite = false
    var appliedFilterModels = [BikesData]()
    var filtering = false
    var favouriteIcon: UIImage?
    
    @IBOutlet weak var bikeModelSearchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bikeModelsCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searching) {
            return filteredBikeModels.count
        }
        else if(filtering) {
            return appliedFilterModels.count
        }
        else {
            return  BikeModelJsonParsing.bikeArr.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bikeModelsCollectionView.dequeueReusableCell(withReuseIdentifier: "BikeModelsCollectionViewCell", for: indexPath) as!
        BikeModelsCollectionViewCell
        ifFavourite = false
        
        if(searching) {
            cell.BikeName.text = filteredBikeModels[indexPath.row].name
            cell.bikeDescription.text = filteredBikeModels[indexPath.row].description
            Alamofire.request(filteredBikeModels[indexPath.row].image).responseJSON(completionHandler: {response in
                cell.modelImageView.image = UIImage(data: response.data!)
            })
            if user?.toFavourites?.allObjects != nil {
                let models = user?.toFavourites?.allObjects as! [Favourites]
                for model in models {
                    if (model.modelName == filteredBikeModels[indexPath.row].name) {
                        ifFavourite = true
                        break
                    }
                }
            }
            if (ifFavourite) {
                favouriteIcon = UIImage(named: "selected.jpg")
            }
            else {
                favouriteIcon = UIImage(named: "notSelect.jpg")
            }
            cell.addToFavouriteButtonClicked.setImage(favouriteIcon, for: UIControl.State.normal)
            cell.addToFavouriteButtonClicked.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
            cell.addToFavouriteButtonClicked.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
            cell.addToFavouriteButtonClicked.tag = indexPath.row
        }
        else if(filtering) {
            cell.BikeName.text = appliedFilterModels[indexPath.row].name
            cell.bikeDescription.text = appliedFilterModels[indexPath.row].description
            Alamofire.request(appliedFilterModels[indexPath.row].image).responseJSON(completionHandler: {response in
                cell.modelImageView.image = UIImage(data: response.data!)
            })
            if user?.toFavourites?.allObjects != nil {
                let models = user?.toFavourites?.allObjects as! [Favourites]
                for model in models {
                    if (model.modelName == appliedFilterModels[indexPath.row].name) {
                        ifFavourite = true
                        break
                    }
                }
            }
            if (ifFavourite) {
                favouriteIcon = UIImage(named: "selected.jpg")
            }
            else {
                favouriteIcon = UIImage(named: "notSelect.jpg")
            }
            cell.addToFavouriteButtonClicked.setImage(favouriteIcon, for: UIControl.State.normal)
            cell.addToFavouriteButtonClicked.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
            cell.addToFavouriteButtonClicked.tag = indexPath.row
            
        }
        else {
            cell.BikeName.text = BikeModelJsonParsing.bikeArr[indexPath.row].name
            cell.bikeDescription.text = BikeModelJsonParsing.bikeArr[indexPath.row].description
            Alamofire.request(BikeModelJsonParsing.bikeArr[indexPath.row].image).responseJSON(completionHandler: {response in
                cell.modelImageView.image = UIImage(data: response.data!)
            })
            if user?.toFavourites?.allObjects != nil {
                let models = user?.toFavourites?.allObjects as! [Favourites]
                for model in models {
                    if (model.modelName == BikeModelJsonParsing.bikeArr[indexPath.row].name) {
                        ifFavourite = true
                        break
                    }
                }
            }
            if (ifFavourite) {
                favouriteIcon = UIImage(named: "selected.jpg")
            }
            else {
                favouriteIcon = UIImage(named: "notSelect.jpg")
            }
            cell.addToFavouriteButtonClicked.setImage(favouriteIcon, for: UIControl.State.normal)
            cell.addToFavouriteButtonClicked.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
            cell.addToFavouriteButtonClicked.tag = indexPath.row
            
            cell.layer.borderWidth = 0.7
        }
        
        return cell
    }
  
    @objc func addToFavourite(sender: UIButton) {
        let indexPath1 = IndexPath(row: sender.tag, section: 0)
        guard let currUser = user else {return}
        if (searching) {
            DBOperations.dbOperationInstance().insertDataToFavorite(mName: filteredBikeModels[indexPath1.row].name, mBrand: fileName, mDesc: filteredBikeModels[indexPath1.row].description, mPrice: filteredBikeModels[indexPath1.row].price, mImage: filteredBikeModels[indexPath1.row].image, mType: filteredBikeModels[indexPath1.row].type, mUser: currUser)
        }
        if (filtering) {
            DBOperations.dbOperationInstance().insertDataToFavorite(mName: appliedFilterModels[indexPath1.row].name, mBrand: fileName, mDesc: appliedFilterModels[indexPath1.row].description, mPrice: appliedFilterModels[indexPath1.row].price, mImage: appliedFilterModels[indexPath1.row].image, mType: appliedFilterModels[indexPath1.row].type, mUser: currUser)
        }
        else {
            DBOperations.dbOperationInstance().insertDataToFavorite(mName: BikeModelJsonParsing.bikeArr[indexPath1.row].name, mBrand: fileName, mDesc: BikeModelJsonParsing.bikeArr[indexPath1.row].description, mPrice: BikeModelJsonParsing.bikeArr[indexPath1.row].price, mImage: BikeModelJsonParsing.bikeArr[indexPath1.row].image, mType: BikeModelJsonParsing.bikeArr[indexPath1.row].type, mUser: currUser)
        }
        bikeModelsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBikeModelViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectedBikeModelViewController") as! SelectedBikeModelViewController
        if(searching) {
            selectedBikeModelViewController.modelName = BikeModelJsonParsing.bikeArr[indexPath.row].name
            selectedBikeModelViewController.modelType = BikeModelJsonParsing.bikeArr[indexPath.row].type
            selectedBikeModelViewController.modelDescription = BikeModelJsonParsing.bikeArr[indexPath.row].description
            selectedBikeModelViewController.modelPrice = BikeModelJsonParsing.bikeArr[indexPath.row].price
            selectedBikeModelViewController.modelImage = BikeModelJsonParsing.bikeArr[indexPath.row].image
            selectedBikeModelViewController.modelBrand = fileName
            self.navigationController?.pushViewController(selectedBikeModelViewController, animated: true)
        }
        else {
            selectedBikeModelViewController.modelName = BikeModelJsonParsing.bikeArr[indexPath.row].name
            selectedBikeModelViewController.modelType = BikeModelJsonParsing.bikeArr[indexPath.row].type
            selectedBikeModelViewController.modelDescription = BikeModelJsonParsing.bikeArr[indexPath.row].description
            selectedBikeModelViewController.modelPrice = BikeModelJsonParsing.bikeArr[indexPath.row].price
            selectedBikeModelViewController.modelImage = BikeModelJsonParsing.bikeArr[indexPath.row].image
            selectedBikeModelViewController.modelBrand = fileName
            
            self.navigationController?.pushViewController(selectedBikeModelViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 190, height: 250)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = DBOperations.dbOperationInstance().fetchMatchedRecord(email: currentUser ?? "")
        
        
        self.bikeModelsCollectionView.delegate = self
        self.bikeModelsCollectionView.dataSource = self
        self.bikeModelSearchBar.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BikeModelJsonParsing.fetchJsonCall(filename: fileName )
        
        let searchTextField = self.bikeModelSearchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.font  = .systemFont(ofSize: 20, weight: .bold)
        searchTextField.backgroundColor = UIColor.black
        titleLabel.text = fileName
        
    }
    
    @IBAction func bikeModelsBackButtonClicked(_ sender: Any) {
        let customTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController")  as! UITabBarController
        self.navigationController?.pushViewController(customTabBarController, animated: true)
    }
    
    @IBAction func allButtonClicked(_ sender: Any) {
        ifFavourite = false
        filtering = false
        self.bikeModelsCollectionView.reloadData()
    }
    @IBAction func gearFilterButtonClicked(_ sender: Any) {
        ifFavourite = false
        let allBikes = BikeModelJsonParsing.bikeArr
        appliedFilterModels = allBikes.filter({$0.type == "Gear"})
        filtering = true
        self.bikeModelsCollectionView.reloadData()
    }
    
    
    @IBAction func gearLessFilterButtonClicked(_ sender: Any) {
        ifFavourite = false
        let allBikes = BikeModelJsonParsing.bikeArr
        appliedFilterModels = allBikes.filter({$0.type == "Gearless"})
        filtering = true
        self.bikeModelsCollectionView.reloadData()
    }
}

extension BikeModelsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(!searchText.isEmpty) {
            searching = true
            filteredBikeModels.removeAll()
            
            for bike in BikeModelJsonParsing.bikeArr {
                if(bike.name.lowercased().contains(searchText.lowercased())) {
                    filteredBikeModels.append(bike)
                }
            }
            
        }
        
        else {
            searching = false
            filteredBikeModels.removeAll()
        }
        bikeModelsCollectionView.reloadData()
    }
}
