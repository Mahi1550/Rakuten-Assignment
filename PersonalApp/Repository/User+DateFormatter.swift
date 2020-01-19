//
//  User+DateFormatter.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 18/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import Foundation

extension User {
    var birthdayInString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let bday = birthday else {
            return "-"
        }
        return dateFormatter.string(from: bday)
    }
}

extension String {
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)
    }
}
