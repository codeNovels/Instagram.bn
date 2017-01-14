/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
	
	var signupMode = true
	
	var activityIndicator = UIActivityIndicatorView()
	
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	func createAlert(title: String, message: String){
		
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
		
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
			
			self.dismiss(animated: true, completion: nil)
			
		}))
		
		self.present(alert, animated: true, completion: nil)
		
	}
	
	@IBOutlet weak var changeSignupModeButton: UIButton!
	
	@IBOutlet weak var messageLabel: UILabel!

	@IBOutlet weak var signupOrLoginButton: UIButton!
	
	@IBAction func signupOrLogin(_ sender: Any) {
		
		if emailTextField.text == "" || passwordTextField.text == "" {
			
			createAlert(title: "Error in form", message: "Please enter a username and password")
			
			
		} else {
			
			activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
			activityIndicator.center = self.view.center
			activityIndicator.hidesWhenStopped = true
			activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
			view.addSubview(activityIndicator)
			activityIndicator.startAnimating()
			UIApplication.shared.beginIgnoringInteractionEvents()
			
			if signupMode {
				// sign up
				
				let user = PFUser()
				
				user.username = emailTextField.text
				user.email = emailTextField.text
				user.password = passwordTextField.text
				

				user.signUpInBackground(block: { (success, error) in
					
					self.activityIndicator.stopAnimating()
					UIApplication.shared.endIgnoringInteractionEvents()
					
					if error != nil {
						
						var displayErrorMessage = "Please try again later"
						
						if let errorMessage = (error! as NSError).userInfo["error"] as? String {
							
							displayErrorMessage = errorMessage
							
						}
						
						self.createAlert(title: "Signup Error", message: displayErrorMessage)
						
					} else {
						
						print("user signed up")
						
						self.performSegue(withIdentifier: "showUserTable", sender: self)
						
					}
					
				})
			
			} else {
				
				// Login Mode
				
				PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
					
					self.activityIndicator.stopAnimating()
					UIApplication.shared.endIgnoringInteractionEvents()
					
					if error != nil {
						
						var displayErrorMessage = "Please try again later"
						
						if let errorMessage = (error! as NSError).userInfo["error"] as? String {
							
							displayErrorMessage = errorMessage
							
						}
						
						self.createAlert(title: "Login Error", message: displayErrorMessage)
						
					} else {
						
						print("logged in ")
						
						self.performSegue(withIdentifier: "showUserTable", sender: self)
						
					}
					
					
				})
				
				
			}
			
		}
		
	}
	
	@IBAction func changeSignupMode(_ sender: Any) {
		
		if signupMode {
			
			// Change to login mode
			
			signupOrLoginButton.setTitle("Log In", for: [])
			
			changeSignupModeButton.setTitle("Sign Up", for: [])
			
			messageLabel.text = "Don't have an account?"
			
			signupMode = false
			
		} else {
			
			// Change to signup mode
			
			signupOrLoginButton.setTitle("Sign Up", for: [])
			
			changeSignupModeButton.setTitle("Log In", for: [])
			
			messageLabel.text = "Already have an account?"
			
			signupMode = true
			
		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		if PFUser.current() != nil {
			
			performSegue(withIdentifier: "showUserTable", sender: self)
			
		}
		
		self.navigationController?.navigationBar.isHidden = true
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
