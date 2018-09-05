//
//  VerifyViewController.swift
//  Sooraj
//
//  Created by Hamed Moosaei on 9/5/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit

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
    
    func checkErrors(){
        if codeTextField.text?.count != 4 {
            codeLabel.textColor = UIColor.red
            codeTextField.borderColor = UIColor.red
            codeLabel.text = "لطفا کد تایید ارسال شده را به درستی وارد نمایید"
            
        }else{
            codeLabel.textColor = UIColor.white
            codeTextField.borderColor = UIColor.white
        }
        if nameTextField.text?.count == 0 {
            nameLabel.textColor = UIColor.red
            nameTextField.borderColor = UIColor.red
            nameLabel.text = "لطفا نام خانوادگی خود را وارد نمایید"
            
        }else{
            nameLabel.textColor = UIColor.white
            nameTextField.borderColor = UIColor.white
        }
    }
    
    @IBAction func enterAction(_ sender: Any) {
        
    }
    
    @IBAction func resendAction(_ sender: Any) {
        
    }
   

}
