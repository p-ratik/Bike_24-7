//
//  CategoriesViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/30/22.
//

import UIKit
import Alamofire
import FirebaseAuth

var currentUser: String?

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categorySearchBar: UISearchBar!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var sideBar: UITableView!
    
    var searching = false
    var filteredCategories = [Category]()
    var menuData = ["Profile", "About Us", "Contact Us", "Sign Out"]
    var isSideViewOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categorySearchBar.delegate = self
        
        categoriesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sideView.isHidden = true
        isSideViewOpen = false
        
        sideView.layer.borderWidth = 0.2
        
        
        let searchTextField = self.categorySearchBar.searchTextField
        searchTextField.textColor = UIColor.black
        searchTextField.font  = .systemFont(ofSize: 20, weight: .bold)
        searchTextField.tintColor = UIColor.white
        CategoryJsonParsing.jsonCall()
        
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
        cell.brandLogo.layer.borderWidth = 0.5
        cell.brandLogo.clipsToBounds = true
        cell.brandLogo.layer.cornerRadius = cell.brandLogo.frame.height/2
        cell.brandLogo.contentMode = .scaleAspectFit
        cell.brandLogo.layer.shadowRadius = 1
        cell.brandLogo.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.brandLogo.layer.shadowOpacity = 0.5
        cell.brandLogo.layer.shadowColor = UIColor.black.cgColor
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
    
    @IBAction func btnMenuClicked(_ sender: Any) {
        sideView.isHidden = false
        sideBar.isHidden = false
        self.view.bringSubviewToFront(sideView)
        if(!isSideViewOpen) {
            isSideViewOpen = true
            sideView.frame = CGRect(x: 0, y: 104, width: 0, height: 739)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 739)
            UIView.animate(withDuration: 0.1) { [self] in
                sideView.frame = CGRect(x: 0, y: 104, width: 268, height: 739)
                sideBar.frame = CGRect(x: 0, y: 0, width: 268, height: 739)
            }
        }
        else {
            isSideViewOpen = false
            sideView.isHidden = true
            sideBar.isHidden = true
            sideView.frame = CGRect(x: 0, y: 104, width: 268, height: 739)
            sideBar.frame = CGRect(x: 0, y: 0, width: 268, height: 739)
            UIView.animate(withDuration: 0.2) { [self] in
                sideView.frame = CGRect(x: 0, y: 104, width: 0, height: 739)
                sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 739)
            }
        }
        
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

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sideBar.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuItem.text = menuData[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(menuData[indexPath.row]) {
        case "Profile":
            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(profileVC, animated: true)
            break
        case "About Us":
            let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            self.navigationController?.pushViewController(aboutVC, animated: true)
            break
        case "Contact Us":
            let contactVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
            self.navigationController?.pushViewController(contactVC, animated: true)
            break
        case "Sign Out":
            do {
                //Signing out of firebase
                try Auth.auth().signOut()
                
                //Navigating back to login view
                self.navigationController?.popToRootViewController(animated: true)
            } catch(let error) {
                
                print(error.localizedDescription)
            }
            break
        default:
            print("no match")
        }
    }
    
    
    
}
