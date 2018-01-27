//
//  Core.swift
//  App
//
//  Created by elaniin on 1/15/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation
import UIKit

/// Core will be used to get elements/ functions which don`t neeed to be created for each class
class Core{
    
    static let shared = Core()
    private init() {}
    
    // MARK: - UI
    
    /// Show alert
     static func alert(message: String, title: String, at viewController: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /// Share app
    static func share(sender: UIView, viewController: UIViewController){
        
        let text = "APP TEXT"
        
        //Enter app link here
        if let url = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {
            let objectsToShare = [text, url, #imageLiteral(resourceName: "logo_white")] as [Any]
            let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            activityController.popoverPresentationController?.sourceView = sender
            viewController.present(activityController, animated: true, completion: nil)
        }
    }
    
    static func circleimage(imageview: UIImageView){
        imageview.layoutIfNeeded()
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
        imageview.clipsToBounds = true
    }
    
    //MARK: - Hexa string color turn into UIColor
    static func hexStringToUIColor (hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //Set a textfield with only one line at the bottom
    static func borderBottonmTextField(textField: UITextField, color: UIColor, tint:UIColor, textcolor: UIColor){
        let borderBottom = CALayer()
        let borderWidth = CGFloat(2.0)
        borderBottom.borderColor = color.cgColor
        borderBottom.frame = CGRect(x: 0, y: textField.frame.height - 1.0, width: textField.frame.width , height: textField.frame.height - 1.0)
        borderBottom.borderWidth = borderWidth
        textField.layer.addSublayer(borderBottom)
        textField.layer.masksToBounds = true
        textField.tintColor = tint
        textField.textColor = textcolor
        
    }
    
    /// MARK: - Validations
    
    
    
    /// Validate email string
    static func validate(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func validatetel(value: String) -> Bool {
        let PHONE_REGEX = "^(6|7)[0-9]{7}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }

    /// MARK: - Table Views
    
    /// Register cell at a table view
    func registerCell(at tableView: UITableView, named: String, withIdentifier: String? = nil) {
        let coffeeCellNib = UINib(nibName: named, bundle: nil)
        tableView.register(coffeeCellNib, forCellReuseIdentifier: withIdentifier ?? named)
    }
    
}
extension UIImageView {
    
    var imageColor: UIColor? {
        set (newValue) {
            if let image = image {
                if newValue != nil {
                    self.image = image.withRenderingMode(.alwaysTemplate)
                    tintColor = newValue
                } else {
                    self.image = image.withRenderingMode(.alwaysOriginal)
                    tintColor = UIColor.clear
                }
            }
        }
        get {
            return tintColor
        }
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}

