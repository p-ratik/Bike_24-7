//
//  CategoriesViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/30/22.
//

import UIKit
import Alamofire


class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    


    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        categoriesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CategoryJsonParsing.jsonCall()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.BrandName.text = CategoryJsonParsing.categoryArr[indexPath.row].name
        Alamofire.request(CategoryJsonParsing.categoryArr[indexPath.row].logo ).responseJSON(completionHandler: {response in
            cell.brandLogo.image = UIImage(data: response.data!)
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
}
