//
//  VerifyViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 9/5/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import IQKeyboardManagerSwift

class VerifyViewController: UIViewController {
    
    var newUser = Int()
    var mobile = String()
    var timer = Timer()
    var time = 60
    
    @IBOutlet weak var logoIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBOutlet weak var reagentLabel: UILabel!
    
    @IBOutlet weak var reagentTextField: DesignableTextField!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var codeTextField: DesignableTextField!
    
    @IBOutlet weak var enterButton: DesignableButton!
    
    @IBOutlet weak var resendButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseTime), userInfo: nil, repeats: true)
    }
    
    @objc func decreaseTime(){
        if time > 0{
            time -= 1
            timerLabel.text = "(" + String(time) + ")"
            
        }else{
//            timer.invalidate()
            resendButton.isEnabled = true
            resendButton.alpha = 1
            timerLabel.text = ""
            
            
        }
    }
    
    @IBAction func resendAction(_ sender: Any) {
        time = 60
        resendButton.isEnabled = false
        resendButton.alpha = 0.5
        // call API
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.optCodeText()
        logoIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        logoIcon.image = UIImage(named: "splashLogo")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if newUser == 0 {
            nameTextField.isHidden = true
            nameLabel.isHidden = true
            reagentLabel.isHidden = true
            reagentTextField.isHidden = true
        }
        timerLabel.text = "(60)"
        resendButton.alpha = 0.5
        enterButton.isEnabled = false
        enterButton.alpha = 0.5
    }
    
    func checkErrors() -> Bool {
        var notError = true
        if codeTextField.text?.count != 5 {
            codeLabel.textColor = UIColor.red
            codeTextField.borderColor = UIColor.red
            codeLabel.text = "لطفا کد تایید ارسال شده را به درستی وارد نمایید"
            notError = false
        }else{
            codeLabel.textColor = UIColor.white
            codeTextField.borderColor = UIColor.white
            optCodeText()
        }
        if newUser == 1{
            if nameTextField.text?.count == 0 {
                nameLabel.textColor = UIColor.red
                nameTextField.borderColor = UIColor.red
                nameLabel.text = "لطفا نام خانوادگی خود را وارد نمایید"
                notError = false
            }else{
                nameLabel.textColor = UIColor.white
                nameTextField.borderColor = UIColor.white
                nameLabel.text = "نام خانوادگی"
            }
        }
        return notError
    }
    
    @IBAction func enterAction(_ sender: Any) {
        if checkErrors() {
            let parameters: Parameters = ["mobile": mobile , "otp": codeTextField.text! , "reagent" : reagentTextField.text! , "last_name" : nameTextField.text!]
            Alamofire.request(Const.BASE_URL + "users/login/otp", method: .post, parameters: parameters , encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
                switch response.result{
                case .success:
                    if response.result.value != nil{
                        
                        let json = JSON(response.result.value!)
                        let resultJson = json["results"]
                        let token = "Bearer " + resultJson["token"].stringValue
                        UserDefaults.standard.set(token, forKey: "token")
                        Utility.getRequest(view: self.view , methodName: "application/index", header: true) {
                            (result) in
                            if (result["success"].intValue == 1)
                            {
                                let jsn = result["results"]
                                let mobile = jsn["mobile"].stringValue
                                UserDefaults.standard.set(mobile, forKey: "mobile")
                                
                                let json = jsn["groups"].arrayValue
                                for jsoon in json {
                                    let groupId = jsoon["id"].intValue
                                    UserDefaults.standard.set(groupId, forKey: "groupId")
                                    let user = jsoon["pivot"]
                                    let userId = user["user_id"].intValue
                                    UserDefaults.standard.set(userId, forKey: "userId")
                                }
                            }
                        }
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                case .failure(let error):
                    print(error)
                    //                    if response.result.value != nil{
                    //                        let json = JSON(response.result.value!)
                    //                        self.mobileLabel.textColor = UIColor.red
                    //                        self.mobileLabel.text = json["message"].stringValue
                    //                    }
                }
            }
        } else {
            print("checkERROR")
            
        }
    }
    
    func optCodeText(){
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "IRANSansMobile", size: 13), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let attrs2 = [NSAttributedStringKey.font : UIFont(name: "IRANSansMobile", size: 13), NSAttributedStringKey.foregroundColor : UIColor.yellow]
        
        let attrs3 = [NSAttributedStringKey.font : UIFont(name: "IRANSansMobile", size: 13), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let attributedString1 = NSMutableAttributedString(string:"کد تایید ارسالی به شماره ", attributes:(attrs1 as Any as! [NSAttributedStringKey : Any]))
        
        let attributedString2 = NSMutableAttributedString(string: mobile, attributes:attrs2 as Any as? [NSAttributedStringKey : Any])
        
        let attributedString3 = NSMutableAttributedString(string:" را وارد نمایید.", attributes:(attrs3 as Any as! [NSAttributedStringKey : Any]))
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        codeLabel.attributedText = attributedString1
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        enterButton.isEnabled = true
        enterButton.alpha = 1
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
    }
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //        print(#function)
        //        if DeviceType.checkiPhoneX() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 40.0
        //        }
        return true
    }
    
    private func textViewDidEndEditing(_ textView: UITextView) {
        //        if DeviceType.checkiPhoneX() {
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 0.0
        //        }
    }
}
