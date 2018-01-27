//
//  RegisterClientViewController.swift
//  BlockchainDigitalIDSV
//
//  Created by elaniin on 1/26/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver
import AccountKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class RegisterClientViewController: UIViewController, AKFViewControllerDelegate, NVActivityIndicatorViewable{

        // MARK: - Let/Var
    var accountKit: AKFAccountKit!
    
        let constantsMessages = Constants()
        let constantsTitles = Titles()
    
        // MARK: - Outlets
        
        @IBOutlet weak var userTextfield: UITextField!
        @IBOutlet weak var passwordTextfield: UITextField!
        @IBOutlet weak var phoneTextfield: UITextField!
    
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.SetUp()
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if (accountKit.currentAccessToken != nil) {
                // if the user is already logged in, go to the main screen
                SwiftyBeaver.debug("User is already logged")
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "showLogin", sender: self)
                })
                
                
            }
            
        }
    
        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // TODO: - Add destinations
        }
        
        // MARK: - Actions
        
        @IBAction func passToValidation(_ sender: Any) {
            
            if self.userTextfield.text?.isEmpty ?? true || (self.userTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                    Core.alert(message: constantsMessages.usernameempty, title: constantsTitles.empty , at: self)
                
            }else if self.passwordTextfield.text?.isEmpty ?? true || (self.passwordTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                Core.alert(message: constantsMessages.passwordempty, title: constantsTitles.empty, at: self)
                
            }else if self.userTextfield.text?.isEmpty ?? true || (self.userTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                Core.alert(message: constantsMessages.phoneempty , title: constantsTitles.empty, at: self)
            }else if Core.validatetel(value: self.phoneTextfield.text!) == false{
                SwiftyBeaver.error("Mal telefono")
                Core.alert(message:constantsMessages.invalidphone, title: constantsTitles.somethingWrong, at: self)
            }else{
                self.startAnimating()
                let params = AddUserParameters.init(username: self.userTextfield.text!, password: self.passwordTextfield.text!, phone: "+503"+self.phoneTextfield.text!)
                
                
               
                
                let completeURL = "http://192.168.137.219/digitalidsv/api.php?mode=users&id=register"
                
                
                GetAPIManager.Post(completeURL, params: params.getUser, success: { (response) in
                    self.stopAnimating()
                    SwiftyBeaver.debug(response)
                    
                }, failure: { (error) in
                    self.stopAnimating()
                    SwiftyBeaver.error(error)
                })
                
              
                
                //login with Phone
                
                let inputState: String = UUID().uuidString
                let viewController:AKFViewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState)
                
                viewController.enableSendToFacebook = true
                self.prepareLoginViewController(viewController)
                self.present(viewController as! UIViewController, animated: true, completion: nil)
            
            
            
            }
    
        }
    
        // MARK: - Helpers/Initializers/Setups
        func SetUp(){
            Core.borderBottonmTextField(textField: self.userTextfield, color: .white, tint: .white, textcolor: .white)
            
            Core.borderBottonmTextField(textField: self.passwordTextfield, color: .white, tint: .white, textcolor: .white)
            
            Core.borderBottonmTextField(textField: self.phoneTextfield, color: .white, tint: .white, textcolor: .white)
            
            // initialize Account Kit
            if accountKit == nil {
                // may also specify AKFResponseTypeAccessToken
                self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
            }
            
            
        }
}

