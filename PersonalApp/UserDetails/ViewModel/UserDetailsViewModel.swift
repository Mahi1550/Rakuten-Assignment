//
//  UserDetailsViewModel.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 17/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol UserDetailsViewModelProtocol {
    var profilePicForUser: UIImage { get }
    var numberOfRows: Int { get }
    func userDataForRowAtIndexPath(indexPath: IndexPath) -> (String, String)
}

class UserDetailsViewModel: UserDetailsViewModelProtocol {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var profilePicForUser: UIImage {
        return UIImage(named: "defaultPic")!
    }
    
    var numberOfRows: Int {
        return 3
    }
    
    func userDataForRowAtIndexPath(indexPath: IndexPath) -> (String, String) {
        if indexPath.row == 0 {
            return (Constants.UserDetails.name, user.name ?? "")
        } else if indexPath.row == 1 {
            return (Constants.UserDetails.birthday, user.birthdayInString)
        }
        return (Constants.UserDetails.email, user.email ?? "")
    }
}
