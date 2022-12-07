//
//  CategoriesViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/30/22.
//

import UIKit
import Alamofire
import FirebaseAuth


class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categorySearchBar: UISearchBar!
    
    var searching = false
    var filteredCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categorySearchBar.delegate = self
        
        categoriesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let searchTextField = self.categorySearchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.font  = .systemFont(ofSize: 20, weight: .bold)
        searchTextField.backgroundColor = UIColor.black
        
        CategoryJsonParsing.jsonCall()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        do {
            //Signing out of firebase
            try Auth.auth().signOut()
            
            //Navigating back to login view
            self.navigationController?.popToRootViewController(animated: true)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredCategories.count
        }
        else {
            return CategoryJsonParsing.categoryArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        if(searching) {
            cell.BrandName.text = filteredCategories[indexPath.row].name
            Alamofire.request(filteredCategories[indexPath.row].logo ).responseJSON(completionHandler: {response in
                cell.brandLogo.image = UIImage(data: response.data!)
            })
        }
        else {
            cell.BrandName.text = CategoryJsonParsing.categoryArr[indexPath.row].name
            Alamofire.request(CategoryJsonParsing.categoryArr[indexPath.row].logo ).responseJSON(completionHandler: {response in
                cell.brandLogo.image = UIImage(data: response.data!)
            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bikeModelsViewController = self.storyboard?.instantiateViewController(withIdentifier: "BikeModelsViewController") as! BikeModelsViewController
        if(searching) {
            bikeModelsViewController.fileName = filteredCategories[indexPath.row].name
            self.navigationController?.pushViewController(bikeModelsViewController, animated: true)
        }
        else {
            bikeModelsViewController.fileName = CategoryJsonParsing.categoryArr[indexPath.row].name
            self.navigationController?.pushViewController(bikeModelsViewController, animated: true)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
}

extension CategoriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(!searchText.isEmpty) {
            searching = true
            filteredCategories.removeAll()
            
            for bike in CategoryJsonParsing.categoryArr {
                if(bike.name.lowercased().contains(searchText.lowercased())) {
                    filteredCategories.append(bike)
                }
            }
            
        }
        
        else {
            searching = false
            filteredCategories.removeAll()
        }
        categoriesCollectionView.reloadData()
    }
}
