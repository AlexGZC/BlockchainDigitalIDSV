//
//  SignInViewController.swift
//  App
//
//  Created by Jonathan Solorzano on 1/15/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit

struct KeychainConfiguration {
    static let serviceName = "TouchMeIn"
    
}

class SignInViewController: UIViewController {

    // MARK: - Let-Var
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    let touchMe = BiometricIDAuth()
    let constants = Constants()
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createInfoLabel: UILabel!
    @IBOutlet weak var touchIDButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Showing is evalutepolicy is working
        touchIDButton.isHidden = !touchMe.canEvaluatePolicy()
        
        switch touchMe.biometricType() {
        case .touchID:
            
            touchIDButton.backgroundColor = .yellow
            touchIDButton.setTitle(self.constants.pendingState, for: .normal)
            
        default:
            touchIDButton.backgroundColor = .red
            touchIDButton.setTitle(self.constants.withoutFingerPrint, for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let touchBool = touchMe.canEvaluatePolicy()
        if touchBool {
            self.touchIDLoginAction()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
    @IBAction func touchIDLoginAction() {
        
        touchMe.authenticateUser() { [weak self] message in
            
                if let message = message {
                    DispatchQueue.main.async {
                    self?.touchIDButton.backgroundColor = .red
                    self?.touchIDButton.setTitle(self?.constants.errorAuth, for: .normal)
                    // if the completion is not nil show an alert
                    let alertView = UIAlertController(title: "Error",
                                                      message: message,
                                                      preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alertView.addAction(okAction)
                    self?.present(alertView, animated: true)
                }
                    
            } else {
                    let storyboard = UIStoryboard(name: "Session", bundle: nil)
                    let openWalkthrough = storyboard.instantiateViewController(withIdentifier: "QRCreatorViewControllerID") as! QRCreatorViewController
                    self?.present(openWalkthrough, animated: true, completion: nil)
                print("is working")
            }
        }
    }
}

