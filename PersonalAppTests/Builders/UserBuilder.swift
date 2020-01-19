//
//  UserBuilder.swift
//  PersonalAppTests
//
//  Created by Mahender Gaddam on 15/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import UIKit
import Foundation
@testable import PersonalApp

class UserBuilder {
    private var id: String = ""
    private var name: String = ""
    private var birthday: Date = Date()
    private var email: String?
    private var password: String?
    
    func withId(_ id: String) -> UserBuilder {
        self.id = id
        return self
    }
    
    func withName(_ name: String) -> UserBuilder {
        self.name = name
        return self
    }
    
    func withBirthday(_ date: Date) -> UserBuilder {
        self.birthday = date
        return self
    }
    
    func withEmail(_ email: String) -> UserBuilder {
        self.email = email
        return self
    }
    
    func withPassword(_ pwd: String) -> UserBuilder {
        self.password = pwd
        return self
    }
    
    func build() -> User {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let user = User(context: managedObjectContext)
        
        user.setValue(id, forKey: "id")
        user.setValue(name, forKey: "name")
        user.setValue(email, forKey: "email")
        user.setValue(birthday, forKey: "birthday")
        user.setValue(password, forKey: "password")

        return user
    }
}
