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
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBOutlet weak var reagentLabel: UILabel!
    
    @IBOutlet weak var reagentTextField: DesignableTextField!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var codeTextField: DesignableTextField!
    
    @IBAction func enterAction(_ sender: Any) {
        
    }
    
    @IBOutlet weak var enterButton: DesignableButton!
    
    @IBOutlet weak var resendButton: UIButton!
    
    @IBAction func resendAction(_ sender: Any) {
        
    }
    
    
    @IBOutlet weak var soorajIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        soorajIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        // Do any additional setup after loading the view.
    }
}
