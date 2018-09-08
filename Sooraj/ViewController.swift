//
//  ViewController.swift
//  Sooraj
//
//  Created by Hamed Moosaei on 9/4/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@IBDesignable
class DesignableTextField: UITextField {
}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

class ViewController: UIViewController , UITextFieldDelegate {
    var newUser = 2
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    @IBOutlet weak var soorajIcon: UIImageView!
    @IBOutlet weak var mobileBtn: DesignableButton!
    @IBOutlet weak var mobileText: DesignableTextField!
    @IBOutlet weak var mobileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        waiting.startAnimating()
        
        let token = UserDefaults.standard.object(forKey: "token") as! String
        let header = ["Authorization" : token]
        Alamofire.request("http://silverbackend.ir/api/application/start", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { response in
            switch response.result{
            case .success:
                if response.result.value != nil {
                    let jsn = JSON(response.result.value!)
                    let resultjsn = jsn["results"]
                    if resultjsn["user_login"].intValue == 1{
                        self.performSegue(withIdentifier: "LoggedIn", sender: self)
                    }else{
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.waiting.stopAnimating()
                            self.waiting.alpha = 0
                            self.comeUpanimation()
                        })
                        
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
        mobileText.delegate = self
        soorajIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func showErrors(){
        mobileLabel.textColor = UIColor.red
        mobileText.borderColor = UIColor.red
        mobileLabel.text = "لطفا شماره خود را به درستی وارد نمایید."
        waiting.stopAnimating()
        waiting.alpha = 0
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        waiting.alpha = 1
        waiting.startAnimating()
        if mobileText.text?.count != 11 {
            showErrors()
        }else{
            //            mobileLabel.textColor = UIColor.white
            //            mobileText.borderColor = UIColor.white
            let parameter: Parameters = ["mobile": mobileText.text!]
            Alamofire.request("http://silverbackend.ir/api/users/send/otp", method: .post, parameters: parameter , encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
                switch response.result{
                case .success:
                    if response.result.value != nil {
                        
                        let jsn = JSON(response.result.value!)
                        if jsn["success"].intValue == 1{
                            let resultjson = jsn["results"]
                            self.newUser = resultjson["new_user"].intValue
                            
                            self.performSegue(withIdentifier: "verifySegue", sender: self)
                        }else{
                            self.mobileLabel.text = jsn["user_message"].stringValue
                            self.mobileLabel.textColor =  UIColor.red
                            self.waiting.alpha = 0
                            self.waiting.stopAnimating()
                        }
                    }
                case .failure(let error):
                    print(error)
                    self.waiting.stopAnimating()
                    self.waiting.alpha = 0
                    self.mobileLabel.textColor = UIColor.red
                    self.mobileLabel.text = "خطای سرور"
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? VerifyViewController{
            vc.mobile = mobileText.text!
            vc.newUser = newUser
        }
    }
    
    private func comeUpanimation(){
        UIView.animate(withDuration: 2, delay: 0, options: [ .curveEaseOut ], animations: {
            self.mobileLabel.transform = CGAffineTransform(translationX: 0, y: -200)
            self.mobileText.transform = CGAffineTransform(translationX: 0, y: -200)
            self.mobileBtn.transform = CGAffineTransform(translationX: 0, y: -200)
        }, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        // moveTextField(textField, moveDistance: -250, up: true)
    //        if mobileText.placeholder == "— — — — —"{
    //            mobileText.placeholder = ""
    //            mobileBtn.isEnabled = true
    //            mobileBtn.alpha = 1
    //        }
    //    }
    
    //    // Finish Editing The Text Field
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //        // moveTextField(textField, moveDistance: -250 , up: false)
    //    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        mobileText.placeholder = ""
        mobileBtn.isEnabled = true
        mobileBtn.alpha = 1
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //    // Move the text field in a pretty animation!
    //    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
    //        let moveDuration = 0.3
    //        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
    //
    //        UIView.beginAnimations("animateTextField", context: nil)
    //        UIView.setAnimationBeginsFromCurrentState(true)
    //        UIView.setAnimationDuration(moveDuration)
    //        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
    //        UIView.commitAnimations()
    //    }
    //
}


