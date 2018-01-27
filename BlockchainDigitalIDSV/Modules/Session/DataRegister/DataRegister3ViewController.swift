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

class DataRegister3ViewController: UIViewController,NVActivityIndicatorViewable {
    
    // MARK: - Let/Var
    let constantsMessages = Constants()
    let constantsTitles = Titles()
    var isHighLighted:Bool = false
    var secureCode = String()
    var setGender = String()
    
    // MARK: - Outlets
    @IBOutlet weak var numeroisssTextfield: UITextField!
    
    @IBOutlet weak var contactTextfield: UITextField!
    @IBOutlet weak var othersTextfield: UITextField!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        if self.setGender == ""{
            self.setGender = "null"
        }else{
            SwiftyBeaver.verbose(setGender)
        }
        
        
        
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
            if self.numeroisssTextfield.text?.isEmpty ?? true || (self.numeroisssTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                
                Core.alert(message: constantsMessages.birthdayempty, title: constantsTitles.empty, at: self)
                
            }else{
                //openUPRegister()
                let url = "http://192.168.137.219/digitalidsv/api.php?mode=fragments&id=add"
                
                let parameters: Parameters = [
                    "type" : "4",
                    "number": self.numeroisssTextfield.text!,
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
                
            }
            
            if self.contactTextfield.text?.isEmpty ?? true || (self.contactTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                
                Core.alert(message: constantsMessages.usernameempty, title: constantsTitles.empty, at: self)
                
            }else if self.othersTextfield.text?.isEmpty ?? true || (self.othersTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
                
                Core.alert(message: constantsMessages.passwordempty, title: constantsTitles.empty, at: self)
            }else{
                
                //openUPRegister()
                let url = "http://192.168.137.219/digitalidsv/api.php?mode=fragments&id=add"
                
                let parameters: Parameters = [
                    "type" : "5",
                    "name": "telefono",
                    "value": self.contactTextfield.text!,
                    "secure_code": "5190aa11"
                ]
                GetAPIManager.Post2(url, params: parameters as [String : AnyObject], success: { (response) in
                    
                    SwiftyBeaver.verbose(response["code"])
                    
                    if response["message"].description == "Success"{
                        SwiftyBeaver.verbose("Buenale")
                        
                        let parameters2: Parameters = [
                            "type" : "6",
                            "name": "sangre",
                            "value": self.othersTextfield.text!,
                            "secure_code": "5190aa11"
                        ]
                        
                        GetAPIManager.Post2(url, params: parameters2 as [String : AnyObject], success: { (response) in
                            
                            SwiftyBeaver.verbose(response["code"])
                            
                            if response["message"].description == "Success"{
                                SwiftyBeaver.verbose("Buenale")
                            }else{
                                Core.alert(message: self.constantsMessages.errorAuth, title: self.constantsTitles.somethingWrong, at: self)
                            }
                            
                            
                            
                            
                            
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
        Core.borderBottonmTextField(textField: self.numeroisssTextfield, color: .blue, tint: .white, textcolor: .white)
        
        Core.borderBottonmTextField(textField: self.othersTextfield, color: .blue, tint: .white, textcolor: .white)
        
        Core.borderBottonmTextField(textField: self.contactTextfield, color: .blue, tint: .white, textcolor: .white)
        
        
        
        
    }
    
    
    
    //Open our Slider after registratation processs
    func openUPRegister(){
        /*
         let storyboard = UIStoryboard(name: "App", bundle: nil)
         let openWalkthrough = storyboard.instantiateViewController(withIdentifier: "SliderTourID") as! SliderTourViewController
         present(openWalkthrough, animated: true, completion: nil)*/
    }
    
}


