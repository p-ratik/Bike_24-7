//
//  DBOperations.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 11/14/22.
//

import UIKit
import CoreData

class DBOperations: NSObject {
    
    //MARK: Instance of DBOperationInstance
    class func dbOperationInstance() -> DBOperations {
        
        struct DBSingleton {
            
            static let dbInstance = DBOperations()
        }
        
        return DBSingleton.dbInstance
    }
    
    //MARK: Inserting Data into User Entity
    func insertDataToUser(name: String, email: String, mobile: String, password: String) {
        
        let managedObject = AppDelegate.sharedAppDelegateInstance().persistentContainer.viewContext
        
        let user = User(context: managedObject)

        user.name = name
        user.email = email
        user.mobile = mobile
        user.password = password
        
        do {
            
            try managedObject.save()
        } catch(let error) {
            
            print("Failed to Save Details")
            print(error.localizedDescription)
        }
    }
    
          
    //MARK: Deleting All Records from user entity
    func deleteUserData() {
        
        let managedObjectDelete = AppDelegate.sharedAppDelegateInstance().persistentContainer.viewContext
        let request : NSFetchRequest<User> = User.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            
            let records = try managedObjectDelete.fetch(request)
            for r in records {
                managedObjectDelete.delete(r)
            }
            
            do {
                
                try managedObjectDelete.save()
            } catch(let error) {
                print(error.localizedDescription)
            }
        } catch(let error){
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: Fetching a particular record from User Entity
    func fetchMatchedRecord(email: String) -> User? {
        
        let managedObjectModel = AppDelegate.sharedAppDelegateInstance().persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        let reqPredicate = NSPredicate(format: "email MATCHES %@", email)
        request.predicate = reqPredicate
        
        do {
            
            let record = try managedObjectModel.fetch(request)
            if(record.isEmpty){
                return nil
            }
            else{
                return record[0]
            }
        } catch(_) {
            
            fatalError("Failed to fetch record.")
        }
    }
}
