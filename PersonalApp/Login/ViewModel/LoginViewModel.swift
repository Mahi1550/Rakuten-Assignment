//
//  LoginViewModel.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 17/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol {
    func requestForCustomLoginWithParams(_ params: [String: String]) -> String?
    func saveUserDetails(attributes: [String: String]) -> String?
    func getUserDetailsFor(id: String) -> User?
}

class LoginViewModel: LoginViewModelProtocol {
    var repository: UserRepositoryProtocol!
    
    init(_ repository: UserRepositoryProtocol = UserRepository.sharedInstance) {
        self.repository = repository
    }
    
    func requestForCustomLoginWithParams(_ params: [String : String]) -> String? {
        return repository.validateUser(name: params["name"] ?? "",
                                password: params["password"] ?? "")
    }
    
    func saveUserDetails(attributes: [String: String]) -> String? {
        let userID = repository.saveUser(attributes: attributes)
        return userID
    }
    
    func getUserDetailsFor(id: String) -> User? {
        guard let user = repository.getUser(id: id) else {
            return nil
        }
        return user
    }
}
