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

class DataRegisterViewController: UIViewController,NVActivityIndicatorViewable {

    // MARK: - Let/Var
    let constantsMessages = Constants()
    let constantsTitles = Titles()
    var isHighLighted:Bool = false
    var secureCode = String()
    var setGender = String()
    let defaults = UserDefaults.standard
    
    // MARK: - Outlets
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var userlastnameTextfield: UITextField!
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        if self.setGender == ""{
            self.setGender = "null"
        }else{
            SwiftyBeaver.verbose(secureCode)
        }
        
        SwiftyBeaver.verbose(UserDefaults.standard.string(forKey: "securecode")!)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
        
        
    }
    
    
    // MARK: - Actions
    
    //Register information
    @IBAction func registerAction(_ sender: Any) {
        
        if secureCode != ""{
            if self.birthdayTextField.text?.isEmpty ?? true || (self.birthdayTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

                Core.alert(message: constantsMessages.birthdayempty, title: constantsTitles.empty, at: self)

            }else if self.usernameTextfield.text?.isEmpty ?? true || (self.usernameTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

                Core.alert(message: constantsMessages.usernameempty, title: constantsTitles.empty, at: self)

            }else if self.userlastnameTextfield.text?.isEmpty ?? true || (self.userlastnameTextfield.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{

                Core.alert(message: constantsMessages.passwordempty, title: constantsTitles.empty, at: self)
            }else if self.setGender == "null"{
                Core.alert(message: constantsMessages.genderempty, title: constantsTitles.empty, at: self)
            }else{

                //openUPRegister()
                let url = "http://192.168.137.219/digitalidsv/api.php?mode=fragments&id=add"
                let params = LoginIsSuccessfull.init(secure_code: self.secureCode, type: "1", name: self.usernameTextfield.text!, lastname: self.userlastnameTextfield.text!, gender: self.setGender, birthdate: self.birthdayTextField.text!)
                
                GetAPIManager.Post2(url, params: params.sendFragement1, success: { (response) in
                    
                    SwiftyBeaver.verbose(response["code"])
                    
                    if response["message"].description == "Success"{
                        SwiftyBeaver.verbose("Buenale")
                    }else{
                        Core.alert(message: self.constantsMessages.errorAuth, title: self.constantsTitles.somethingWrong, at: self)
                    }
                    
                    self.defaults.set("first app is over", forKey: defaultsKeys.token)
                    
                    
                    self.stopAnimating()
                }) { (error) in
                    SwiftyBeaver.error(error)
                    self.stopAnimating()
                }

            }
        }

    }
    
    //SelectBirthday,action to set a date
    @IBAction func selectBirhtday(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    
    @IBAction func genderFemaleAction(_ sender: UIButton) {
        
            SwiftyBeaver.warning("empty gender")
        
            self.womenButton.backgroundColor = Core.hexStringToUIColor(hex: "#009D9A")
            self.manButton.backgroundColor   = Core.hexStringToUIColor(hex: "#1C2742")
            self.setGender = "F"
        SwiftyBeaver.verbose(self.setGender)
        
        
    }
    
    @IBAction func genderMaleAction(_ sender: Any) {
        
            SwiftyBeaver.warning("empty gender")
        
            self.manButton.backgroundColor   = Core.hexStringToUIColor(hex: "#009D9A")
            self.womenButton.backgroundColor = Core.hexStringToUIColor(hex: "#1C2742")
            self.setGender = "M"
            SwiftyBeaver.verbose(self.setGender)
        
    }
    
    

    
    
    
    
    // MARK: - Helpers/Initializers/Setups
    
    //General setup
    func SetUp(){
        Core.borderBottonmTextField(textField: self.birthdayTextField, color: .blue, tint: .white, textcolor: .white)
        
        Core.borderBottonmTextField(textField: self.userlastnameTextfield, color: .blue, tint: .white, textcolor: .white)
        
        Core.borderBottonmTextField(textField: self.usernameTextfield, color: .blue, tint: .white, textcolor: .white)
        
        
        
        
    }
    
    //Set te values changes
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        
        self.birthdayTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    //Open our Slider after registratation processs
    func openUPRegister(){
        /*
        let storyboard = UIStoryboard(name: "App", bundle: nil)
        let openWalkthrough = storyboard.instantiateViewController(withIdentifier: "SliderTourID") as! SliderTourViewController
        present(openWalkthrough, animated: true, completion: nil)*/
    }

}
