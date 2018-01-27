//
//  ReadQRViewController.swift
//  BlockchainDigitalIDSV
//
//  Created by elaniin on 1/26/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
import Alamofire
import SwiftyJSON

class ReadQRViewController:UIViewController, QRCodeReaderViewControllerDelegate {
    @IBOutlet weak var previewView: QRCodeReaderView! {
        didSet {
            previewView.setupComponents(showCancelButton: false, showSwitchCameraButton: false, showTorchButton: false, showOverlayView: true, reader: reader)
        }
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    let defaults = UserDefaults.standard
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader          = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton = true
            
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction Method
    

    
    // MARK: - Custom Method
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            default:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    @IBAction func scanInModalAction(_ sender: AnyObject) {
        guard checkScanPermissions() else { return }
        
        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate               = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let result = result {
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }
        }
        
        present(readerVC, animated: true, completion: nil)
    }
    
    @IBAction func scanInPreviewAction(_ sender: Any) {
        guard checkScanPermissions(), !reader.isRunning else { return }
        
        reader.didFindCode = { result in
            print("Completion with result: \(result.value) of type \(result.metadataType)")
        }
        
        reader.startScanning()
    }
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            let alert = UIAlertController(
                title: "QRCodeReader",
                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            let url = "http://192.168.137.219/digitalidsv/api.php?mode=fragments&id=get"
            
            let parameters: Parameters = [
                "entity" : "1",
                "secure_code": UserDefaults.standard.string(forKey: "securecode")?.description
            ]
            
            GetAPIManager.Post2(url, params: parameters as [String : AnyObject], success: { (response) in
                
               // SwiftyBeaver.verbose(response["code"])
                
                if response["message"].description == "Success"{
                    print("Buenale")
                }else{
                    Core.alert(message: "error", title: "error", at: self!)
                }
                
                
                //5190aa11
               
            }) { (error) in
                //SwiftyBeaver.error(error)
                
            }
            
            
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        print("Switching capturing to: \(newCaptureDevice.device.localizedName)")
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}
    



