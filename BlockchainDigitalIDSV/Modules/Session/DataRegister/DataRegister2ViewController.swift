//
//  DataRegisterViewController.swift
//  beerapp
//
//  Created by elaniin on 1/24/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Alamofire
import NVActivityIndicatorView

class DataRegister2ViewController: UIViewController,NVActivityIndicatorViewable {
    
    // MARK: - Let/Var
    let constantsMessages = Constants()
    let constantsTitles = Titles()
    var isHighLighted:Bool = false
    var secureCode = String()

    
    // MARK: - Outlets
    @IBOutlet weak var numeroNitTextfield: UITextField!

    @IBOutlet weak var adminTextfield: UITextField!
    @IBOutlet weak var admnumberTextfield: UITextField!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        
        
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
        
        
    }
    
    
    // MARK: - Actions
    
    //Register information
    @IBAction func registerAction(_ sender: Any) {
        secureCode = "5190aa11"
        if secureCode != ""{
            if self.numeroNitTextfield.text?.isEmpty ?? true || (self.numeroNitTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                
                Core.alert(message: constantsMessages.birthdayempty, title: constantsTitles.empty, at: self)
                
        }else if self.adminTextfield.text?.isEmpty ?? true || (self.adminTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                
                Core.alert(message: constantsMessages.usernameempty, title: constantsTitles.empty, at: self)
                
            }else if self.admnumberTextfield.text?.isEmpty ?? true || (self.admnumberTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                
                Core.alert(message: constantsMessages.passwordempty, title: constantsTitles.empty, at: self)
            }else{
                
                //openUPRegister()
                let url = "http://192.168.137.219/digitalidsv/api.php?mode=fragments&id=add"
            
            let parameters: Parameters = [
                "type" : "3",
                "manager": self.adminTextfield.text!,
                "number": self.admnumberTextfield.text!,
                "secure_code": "5190aa11"
            ]
            GetAPIManager.Post2(url, params: parameters as [String : AnyObject], success: { (response) in
                    
                    SwiftyBeaver.verbose(response["code"])
                    
                    if response["message"].description == "Success"{
                        SwiftyBeaver.verbose("ok")
                        
                        
                        //openUPRegister()
                        let url = "http://192.168.137.219/digitalidsv/api.php?mode=fragments&id=add"
                        
                        let parameters: Parameters = [
                            "type" : "2",
                            "number": self.numeroNitTextfield.text!,
                            "secure_code": "5190aa11"
                        ]
                        
                        GetAPIManager.Post2(url, params: parameters as [String : AnyObject], success: { (response) in
                            
                            SwiftyBeaver.verbose(response["code"])
                            
                            if response["message"].description == "Success"{
                                SwiftyBeaver.verbose("Buenale")
                            }else{
                                Core.alert(message: self.constantsMessages.errorAuth, title: self.constantsTitles.somethingWrong, at: self)
                            }
                            
                            
                            //5190aa11
                            self.stopAnimating()
                        }) { (error) in
                            SwiftyBeaver.error(error)
                            self.stopAnimating()
                        }
                        
                        
                        
                        
                    }else{
                        Core.alert(message: self.constantsMessages.errorAuth, title: self.constantsTitles.somethingWrong, at: self)
                    }
                    
                    
                    
                    self.stopAnimating()
                }) { (error) in
                    SwiftyBeaver.error(error)
                    self.stopAnimating()
                }
                
            }
        }
        
    }
    

    
    
    
    // MARK: - Helpers/Initializers/Setups
    
    //General setup
    func SetUp(){
        Core.borderBottonmTextField(textField: self.numeroNitTextfield, color: .blue, tint: .white, textcolor: .white)
        
        Core.borderBottonmTextField(textField: self.admnumberTextfield, color: .blue, tint: .white, textcolor: .white)
        
        Core.borderBottonmTextField(textField: self.adminTextfield, color: .blue, tint: .white, textcolor: .white)
        
        
        
        
    }
    

    
    //Open our Slider after registratation processs
    func openUPRegister(){
        /*
         let storyboard = UIStoryboard(name: "App", bundle: nil)
         let openWalkthrough = storyboard.instantiateViewController(withIdentifier: "SliderTourID") as! SliderTourViewController
         present(openWalkthrough, animated: true, completion: nil)*/
    }
    
}

