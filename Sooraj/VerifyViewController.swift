//
//  VerifyViewController.swift
//  Sooraj
//
//  Created by Hamed Moosaei on 9/5/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {

    @IBOutlet weak var soorajIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        soorajIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        // Do any additional setup after loading the view.
    }
}
