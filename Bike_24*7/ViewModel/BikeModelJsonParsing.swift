//
//  BikeModelJsonParsing.swift
//  Bike_24*7
//
//  Created by Capgemini-DA161 on 12/7/22.
//

import Foundation

class BikeModelJsonParsing: NSObject {
    
    static var bikeArr: [BikesData] = []
    
    static func fetchJsonCall(filename: String) {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String : String]]
                bikeArr = []
                for dict in json {
                    let id = dict["id"]!
                    let name = dict["name"]!
                    let type = dict["type"]!
                    let description = dict["description"]!
                    let image = dict["image"]!
                    let price = dict["Price"]!
                    let data = BikesData(id: id, name: name, type: type, description: description, image: image, price: price)
                    bikeArr.append(data)
                }
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
