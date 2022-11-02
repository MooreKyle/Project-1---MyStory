//
//  ViewController.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/25/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signupButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        
    }

  @IBAction func onLoginButtonTap(_ sender: UIButton) {
    guard !isUsernameOrPasswordEmpty() else {
      displayEmptyTextFieldError()
      return
    }
    let username = usernameTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    PFUser.logInWithUsername(inBackground: username, password: password) { [unowned self] user, error in
      if let error = error {
        self.displayLoginError(error: error)
      } else {
        print("User \(user?.username ?? "") login success")
        NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
      }
    }
  }
  
  @IBAction func onSignupButtonTap(_ sender: UIButton) {
    guard !isUsernameOrPasswordEmpty() else {
      displayEmptyTextFieldError()
      return
    }
    let newUser = PFUser()
    newUser.username = usernameTextField.text
    newUser.password = passwordTextField.text
    newUser.signUpInBackground { [unowned self] isSuccess, error in
      if let error = error {
        self.displaySignupError(error: error)
      } else {
        print("User \(newUser.username!) Registered Successfully")
        NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
      }
    }
  }
  
  private func isUsernameOrPasswordEmpty() -> Bool {
    return usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
  }
  
  private func displayEmptyTextFieldError() {
    let title = "Error"
    let message = "Username and password field cannot be empty"
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(OKAction)
    present(alertController, animated: true)
  }
  
  private func displayLoginError(error: Error) {
    let title = "Login Error"
    let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(OKAction)
    present(alertController, animated: true)
  }
  
  private func displaySignupError(error: Error) {
    let title = "Sign up error"
    let message = "Oops! Something went wrong while signing up: \(error.localizedDescription)"
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(OKAction)
    present(alertController, animated: true)
  }
}

