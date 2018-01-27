//
//  SignInViewControllerCheckViewController.swift
//  BlockchainDigitalIDSV
//
//  Created by elaniin on 1/27/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class SignInViewControllerCheck2ViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Let/Var
    let constantsMessages = Constants()
    let constantsTitles = Titles()
    var saveUserDataArray = [LoginIsSuccessfull]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var userTexfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
    }
    
    // MARK: - Actions
    
    @IBAction func loginSuccessfull(_ sender: Any) {
        if self.userTexfield.text?.isEmpty ?? true || (self.userTexfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            Core.alert(message: constantsMessages.usernameempty, title: constantsTitles.empty, at: self)
        }else if self.passwordTextfield.text?.isEmpty ?? true || (self.passwordTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            Core.alert(message: constantsMessages.passwordempty, title: constantsTitles.empty, at: self)
            
        }else{
            self.startAnimating()
            let url = "http://192.168.137.219/digitalidsv/api.php?mode=entity&id=login"
            let params = UserAdmin.init(email: "eduardo.linares@elaniin.com", password: "wp6883")
            GetAPIManager.Post(url, params: params.loginUser, success: { (response) in
                
                SwiftyBeaver.verbose(response["code"])
                
               
                    let storyboard = UIStoryboard(name: "Session", bundle: nil)
                    let openRegisterData = storyboard.instantiateViewController(withIdentifier: "ReadQRViewControllerID") as! ReadQRViewController
                    
                    
                    self.present(openRegisterData, animated: true, completion: nil)
                
                
                
                
                self.stopAnimating()
            }) { (error) in
                SwiftyBeaver.error(error)
                self.stopAnimating()
            }
        }
        
    }
    
    // MARK: - Helpers/Initializers/Setups
    func setUp(){
        Core.borderBottonmTextField(textField: self.userTexfield, color: .blue, tint: .white, textcolor: .white)
        Core.borderBottonmTextField(textField: self.passwordTextfield, color: .blue, tint: .white, textcolor: .white)
        
        
    }
}

