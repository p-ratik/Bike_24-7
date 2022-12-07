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
    
    @IBOutlet weak var bikeModelSearchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bikeModelsCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searching) {
            return filteredBikeModels.count
        }
        else {
            return  BikeModelJsonParsing.bikeArr.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bikeModelsCollectionView.dequeueReusableCell(withReuseIdentifier: "BikeModelsCollectionViewCell", for: indexPath) as!
        BikeModelsCollectionViewCell
        if(searching) {
            cell.BikeName.text = filteredBikeModels[indexPath.row].name
            cell.bikeDescription.text = filteredBikeModels[indexPath.row].description
            Alamofire.request(filteredBikeModels[indexPath.row].image).responseJSON(completionHandler: {response in
                cell.modelImageView.image = UIImage(data: response.data!)
            })
        }
        else {
            cell.BikeName.text = BikeModelJsonParsing.bikeArr[indexPath.row].name
            cell.bikeDescription.text = BikeModelJsonParsing.bikeArr[indexPath.row].description
            Alamofire.request(BikeModelJsonParsing.bikeArr[indexPath.row].image).responseJSON(completionHandler: {response in
                cell.modelImageView.image = UIImage(data: response.data!)
            })
        }
        cell.layer.borderWidth = 0.7
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 190, height: 250)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let categoriesViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
        self.navigationController?.pushViewController(categoriesViewController, animated: true)
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
