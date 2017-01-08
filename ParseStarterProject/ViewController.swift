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
	
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var changeSignupModeButton: UIButton!
	
	@IBOutlet weak var messageLabel: UILabel!

	@IBOutlet weak var signupOrLoginButton: UIButton!
	
	@IBAction func signupOrLogin(_ sender: Any) {
		
		if emailTextField.text == "" || passwordTextField.text == "" {
			
			let alert = UIAlertController(title: "Error in form", message: "Please enter a username and password", preferredStyle: UIAlertControllerStyle.alert)
			
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
				
				self.dismiss(animated: true, completion: nil)
				
			}))
			
				self.present(alert, animated: true, completion: nil)
			
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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
