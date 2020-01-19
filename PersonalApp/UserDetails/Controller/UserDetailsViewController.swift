//
//  UserDetailsViewController.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 17/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import UIKit
import FBSDKLoginKit

var detailsScreenSegueIdentifier: String = "ShowDetails"

class UserDetailsViewController: UIViewController {
    var userDetailsViewModel: UserDetailsViewModelProtocol!
    @IBOutlet weak var detailsTableView: UITableView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsTableView.tableFooterView = UIView()
        self.navigationItem.setHidesBackButton(true, animated: true);
    }
}

extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userDetailsViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        let (title, value) = userDetailsViewModel.userDataForRowAtIndexPath(indexPath: indexPath)
        cell.configure(title: title, value: value)
        return cell
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension UserDetailsViewController {
    @IBAction func logoutButtonAction(_ sender: Any) {
        LoginManager().logOut()
        UserDefaults.standard.removeObject(forKey: Constants.Facebook.ID)
        self.navigationController?.popViewController(animated: true)
    }
}
