//
//  LoginViewController.swift
//  PersonalApp
//
//  Created by Mahender Gaddam on 16/01/20.
//  Copyright © 2020 Mahender Gaddam. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loginViewModel: LoginViewModelProtocol
    let permissions: [Permission] = [.publicProfile, .userBirthday, .email]
    
    required init?(coder: NSCoder) {
        loginViewModel = LoginViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForLoggedInUser()
        userNameTF.addBottomBorder()
        passwordTF.addBottomBorder()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTF.text = ""
        passwordTF.text = ""
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func checkForLoggedInUser() {
        if AccessToken.isCurrentAccessTokenActive {
            guard let id = UserDefaults.standard.value(forKey: Constants.Facebook.ID) as? String else {
                return
            }
            guard let user = loginViewModel.getUserDetailsFor(id: id) else {
                return
            }
            self.performSegue(withIdentifier: detailsScreenSegueIdentifier, sender: user)
        }
    }
    
    func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Facebook Login Actions

extension LoginViewController {
    @IBAction func facebookLoginAction(_ sender: Any) {
        self.activityIndicator.startAnimating()
        let loginManager = LoginManager()
        loginManager.logIn(permissions: permissions,
                           viewController: self) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    func loginManagerDidComplete(_ result: LoginResult) {
        var alertController: UIAlertController!
        switch result {
        case .cancelled:
            alertController = UIAlertController(
                title: Constants.AlertTitle.loginCancelled,
                message: Constants.AlertMessage.userCancelledLogin,
                preferredStyle: .alert
            )
            showAlert(controller: alertController)

        case .failed(let error):
            alertController = UIAlertController(
                title: Constants.AlertTitle.loginFailed,
                message: "\(Constants.AlertMessage.loginFailedMsg) \(error)",
                preferredStyle: .alert
            )
            showAlert(controller: alertController)

        case .success(_, _, _):
            doGraphApiRequestToGetUserDetails()
        }
    }
    
    private func doGraphApiRequestToGetUserDetails() {
        let request = GraphRequest.init(graphPath: "me", parameters: ["fields": "name,email"])
        request.start { [unowned self] (connection, result, error) in
            self.activityIndicator.stopAnimating()
            if error == nil {
                let userId = self.loginViewModel.saveUserDetails(attributes: result as! [String: String])
                if userId != nil {
                    if let user = self.loginViewModel.getUserDetailsFor(id: userId!) {
                        UserDefaults.standard.set(user.id, forKey: Constants.Facebook.ID)
                        self.showUserDetailsScreen(user: user)
                        return
                    }
                }
            }
            let alertController = UIAlertController(
                title: Constants.AlertTitle.userAccessDenied,
                message: Constants.AlertMessage.UnableToFetchDetails,
                preferredStyle: .alert
            )
            self.showAlert(controller: alertController)
        }
    }
    
    func showAlert(controller: UIAlertController) {
        self.activityIndicator.stopAnimating()
        controller.addAction(UIAlertAction.init(title: Constants.AlertActionTitle.Ok, style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}

//MARK: Navigation Methods

extension LoginViewController {
    func showUserDetailsScreen(user: User) {
        self.performSegue(withIdentifier: detailsScreenSegueIdentifier, sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsScreenSegueIdentifier {
            let vc = segue.destination as! UserDetailsViewController
            vc.userDetailsViewModel = UserDetailsViewModel(user: sender as! User)
        }
    }
}

//MARK: Custom Login Actions

extension LoginViewController {
    @IBAction func customLoginAction(_ sender: Any) {
        view.endEditing(true)
        let userCredentials = ["name": userNameTF.text ?? "", "password": passwordTF.text ?? ""]
        let userId = loginViewModel.requestForCustomLoginWithParams(userCredentials)
        if userId != nil {
            if let user = self.loginViewModel.getUserDetailsFor(id: userId!) {
                showUserDetailsScreen(user: user)
                return
            }
        }
        let alertController = UIAlertController(
            title: Constants.AlertTitle.userAccessDenied,
            message: Constants.AlertMessage.invalidCredentials,
            preferredStyle: .alert
        )
        self.showAlert(controller: alertController)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
