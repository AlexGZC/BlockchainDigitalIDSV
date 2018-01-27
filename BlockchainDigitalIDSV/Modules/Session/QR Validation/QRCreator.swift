//
//  QRCreator.swift
//  BlockchainDigitalIDSV
//
//  Created by elaniin on 1/27/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//


import UIKit
import SwiftyBeaver

class QRCreatorViewController: UIViewController {
    
    // MARK: - Let/Var
    let defaults = UserDefaults.standard
    // MARK: - Outlets
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.text = UserDefaults.standard.string(forKey: "securecode")?.description
        if let myString = myTextField.text
        {
            
            let data = myString.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            
            let img = UIImage(ciImage: (filter?.outputImage)!)
            
            myImageView.image = img
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Add destinations
}

// MARK: - Actions
    @IBAction func CreateMyQUR(_ sender: Any)
    {
        
    }

// MARK: - Helpers/Initializers/Setups

}
