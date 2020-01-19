//
//  Constants.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 18/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import Foundation

struct Constants {
    struct AlertTitle {
        static var loginCancelled = "Login Cancelled"
        static var loginFailed = "Login Fail"
        static var userAccessDenied = "User Access Denied"
    }
    
    struct AlertMessage {
        static var userCancelledLogin = "User cancelled login."
        static var loginFailedMsg = "Login failed with error "
        static var UnableToFetchDetails = "Unable to fetch user details"
        static var invalidCredentials = "Invalid Credentials"
    }
    
    struct AlertActionTitle {
        static var Ok = "OK"
    }
    
    struct Facebook {
        static var ID = "facebookID"
    }
    
    struct UserDetails {
        static var name = "Name:"
        static var email = "email:"
        static var birthday = "Birthday:"
    }
    
    struct UserKeys {
        static var id = "id"
        static var name = "name"
        static var email = "email"
        static var birthday = "birthday"
        static var password = "password"
    }
}
