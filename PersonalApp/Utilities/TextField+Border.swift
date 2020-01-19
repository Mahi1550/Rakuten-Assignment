//
//  TextField+Border.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 18/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
