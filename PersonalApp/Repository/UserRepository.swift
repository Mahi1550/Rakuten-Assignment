//
//  UserRepository.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 18/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol UserRepositoryProtocol {
    func saveUser(attributes: [String: String]) -> String?
    func getUser(id: String) -> User?
    func validateUser(name: String, password: String) -> String?
    func loadDefaultUserData()
}

class UserRepository: UserRepositoryProtocol {
    static var sharedInstance: UserRepositoryProtocol = UserRepository()
    private var manageObjectContext: NSManagedObjectContext?
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveUser(attributes: [String: String]) -> String? {
        manageObjectContext?.refreshAllObjects()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "User", into: manageObjectContext!)
        
        entity.setValue(attributes[Constants.UserKeys.id], forKey: Constants.UserKeys.id)
        entity.setValue(attributes[Constants.UserKeys.name], forKey: Constants.UserKeys.name)
        entity.setValue(attributes[Constants.UserKeys.email], forKey: Constants.UserKeys.email)
        if let dateString = attributes[Constants.UserKeys.birthday] {
            entity.setValue(dateString.toDate, forKey: Constants.UserKeys.birthday)
        }
        do {
            try manageObjectContext?.save()
        }
        catch let error as NSError {
            if error.code == 133021 { // user already exists
                return entity.value(forKey: Constants.UserKeys.id) as? String
            }
            manageObjectContext?.delete(entity)
            print("Could not save. \(error.localizedDescription)")
            return nil
        }
        return entity.value(forKey: Constants.UserKeys.id) as? String
    }
    
    func getUser(id: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(Constants.UserKeys.id) = %@", id)
        do {
            let result = try manageObjectContext?.fetch(fetchRequest)
            guard let users = result, users.count > 0 else {
                return nil
            }
            return users[0]
        } catch let error as NSError {
            print("Retreive Failed. \(error.localizedDescription)")
            return nil
        }
    }
    
    func validateUser(name: String, password: String) -> String? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(Constants.UserKeys.name) = %@ AND \(Constants.UserKeys.password) = %@", name, password)
        fetchRequest.fetchLimit = 1
        
        do {
            let result = try manageObjectContext?.fetch(fetchRequest)
            guard let users = result, users.count > 0 else {
                return nil
            }
            return users[0].id
        } catch let error as NSError {
            print("Validation Failed. \(error.localizedDescription)")
            return nil
        }
    }
    
    func loadDefaultUserData() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "User", into: manageObjectContext!)
        entity.setValue("123", forKey: Constants.UserKeys.id)
        entity.setValue("admin", forKey: Constants.UserKeys.name)
        entity.setValue("password", forKey: Constants.UserKeys.password)
        entity.setValue("test@gmail.com", forKey: Constants.UserKeys.email)
        entity.setValue(Date(), forKey: Constants.UserKeys.birthday)
        
        do {
            try manageObjectContext?.save()
        }
        catch {
            print("Could not save or Data already exists")
        }
    }
}
