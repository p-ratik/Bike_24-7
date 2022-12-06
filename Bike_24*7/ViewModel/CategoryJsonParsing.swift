//
//  CategoryJsonParsing.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/1/22.
//

import Foundation


class CategoryJsonParsing: NSObject {
    
    static var categoryArr: [Category] = []
    
    static func jsonCall() {
        if let path = Bundle.main.path(forResource: "BikeCategories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String : String]]
                for dict in json {
                    let name = dict["Name"]!
                    let logo = dict["Logo"]!
                    let category = Category(name: name, logo: logo)
                    categoryArr.append(category)
                }
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
