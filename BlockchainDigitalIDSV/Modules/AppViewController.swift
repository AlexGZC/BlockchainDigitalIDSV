//
//  AppViewController.swift
//  BlockchainDigitalIDSV
//
//  Created by elaniin on 1/26/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {


        // MARK: - Let/Var
        var openRegistrationString = "Si no posees cuenta Registrate"
        var myMutableString = NSMutableAttributedString()
    
        // MARK: - Outlets
    
        @IBOutlet weak var openRegistrationButton: UIButton!
        @IBOutlet weak var logoImageview: UIImageView!
    
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
        
        
        // MARK: - Helpers/Initializers/Setups
    func setUp(){
        
        myMutableString = NSMutableAttributedString(string: self.openRegistrationString, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10)])
        
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: Core.hexStringToUIColor(hex: "#5abfcc"), range: NSRange(location:20,length:10))
        
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:19))
        
        self.openRegistrationButton.setAttributedTitle(self.myMutableString, for: .normal)
        
        
        self.logoImageview.imageColor = .white
        
        
        
    }


}
