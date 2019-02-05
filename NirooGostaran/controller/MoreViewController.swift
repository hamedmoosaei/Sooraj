//
//  MoreViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/12/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    let topView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewinit(titleString: "بیشتر")
        defaultInit()
    }

    func topViewinit(titleString: String){
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topView)
        NSLayoutConstraint(item: topView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.083, constant: 0).isActive = true
        
        topView.image = UIImage(named: "topView")
        topView.contentMode = .scaleToFill
        
        let topViewText: UILabel = UILabel()
        
        topViewText.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(topViewText)
        
        NSLayoutConstraint(item: topViewText, attribute: .bottom, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: -3).isActive = true
        NSLayoutConstraint(item: topViewText, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        topViewText.text = titleString
        topViewText.font = UIFont(name: "IRANSansMobile", size: 15)
        
    }
    func defaultInit(){
        
        let image = UIImageView(image: UIImage(named: "blackback"))
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
    }
}
