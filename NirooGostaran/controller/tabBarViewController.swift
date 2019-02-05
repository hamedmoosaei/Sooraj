//
//  tabBarViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/12/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit

class tabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 2
        self.tabBar.barTintColor = UIColor.black
    }
}
