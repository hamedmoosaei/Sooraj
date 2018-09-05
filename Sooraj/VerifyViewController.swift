//
//  VerifyViewController.swift
//  Sooraj
//
//  Created by Hamed Moosaei on 9/5/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VerifyViewController: UIViewController {
    
    var mobile = String()
    
    @IBOutlet weak var soorajIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBOutlet weak var reagentLabel: UILabel!
    
    @IBOutlet weak var reagentTextField: DesignableTextField!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var codeTextField: DesignableTextField!
    
    @IBOutlet weak var enterButton: DesignableButton!
    
    @IBOutlet weak var resendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soorajIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
    }
    
    func checkErrors() -> Bool {
        if codeTextField.text?.count != 4 {
            codeLabel.textColor = UIColor.red
            codeTextField.borderColor = UIColor.red
            codeLabel.text = "لطفا کد تایید ارسال شده را به درستی وارد نمایید"
            return false
        }else{
            codeLabel.textColor = UIColor.white
            codeTextField.borderColor = UIColor.white
        }
        if nameTextField.text?.count == 0 {
            nameLabel.textColor = UIColor.red
            nameTextField.borderColor = UIColor.red
            nameLabel.text = "لطفا نام خانوادگی خود را وارد نمایید"
            return false
        }else{
            nameLabel.textColor = UIColor.white
            nameTextField.borderColor = UIColor.white
        }
        return true
    }
    
    @IBAction func enterAction(_ sender: Any) {
        if checkErrors() {
            let parameters: Parameters = ["mobile": mobile , "otp": codeTextField.text! , "reagent" : reagentTextField.text! , "last_name" : nameTextField.text!]
            Alamofire.request("http://silverbackend.ir/api/users/send/otp", method: .post, parameters: parameters , encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
                switch response.result{
                case .success:
                    if response.result.value != nil{
                        let json = JSON(response.result.value!)
                        let resultJson = json["result"]
                        UserDefaults.standard.set(resultJson, forKey: "user")
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
            
        }
    }
    
    @IBAction func resendAction(_ sender: Any) {
        
    }
   

}
