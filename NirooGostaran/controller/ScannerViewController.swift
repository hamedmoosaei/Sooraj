//
//  ScannerViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/23/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//
import AVFoundation
import UIKit


class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var backView: UIView = UIView()
    var src: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = view.layer.bounds

        view.layer.addSublayer(previewLayer)
        
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        NSLayoutConstraint(item: backView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.17, constant: 0).isActive = true
        backView.backgroundColor = UIColor.lightGray
        backView.alpha = 0.5
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(label)
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: backView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: backView, attribute: .height, multiplier: 0.7, constant: 0).isActive = true
        label.textAlignment = .center
        label.text = "انصراف"
        label.font = UIFont(name: "IRANSansMobile", size: 20)

        let tapCancelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openQuickPay(_:)))
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(tapCancelGestureRecognizer)

        view.bringSubview(toFront: backView)
        captureSession.startRunning()
    }
    @objc func openQuickPay(_ sender:UITapGestureRecognizer){
        dismiss(animated: true)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
//        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        switch src {
        case "info":
            print("info")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: WarrantyInfoViewController = storyboard.instantiateViewController(withIdentifier: "2") as! WarrantyInfoViewController
            vc.codeTextfield.text = code
            self.present(vc, animated: true, completion: nil)
        case "activate":
            print("activate")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: WarrantyActivateViewController = storyboard.instantiateViewController(withIdentifier: "3") as! WarrantyActivateViewController
            vc.codeTextfield.text = code
            self.present(vc, animated: true, completion: nil)
        case "battery":
            print("battery")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: BatteryReturnViewController = storyboard.instantiateViewController(withIdentifier: "4") as! BatteryReturnViewController
            vc.codeTextfield.text = code
            self.present(vc, animated: true, completion: nil)
        default:
            print("default")
        }
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
