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
    var image : UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewinit(titleString: "بیشتر")
        defaultInit()
        showMore()
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
        
        image = UIImageView(image: UIImage(named: "blackback"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        view.addSubview(image)
        NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
    }
    
    func showMore(){
        let logo = UIImageView(image: UIImage(named: "splashLogo"))
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(logo)
        
        NSLayoutConstraint(item: logo, attribute: .top, relatedBy: .equal, toItem: image, attribute: .top, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: logo, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.45, constant: 0).isActive = true
    

        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(centerView)
        NSLayoutConstraint(item: centerView, attribute: .top, relatedBy: .equal, toItem: logo, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 1.1, constant: 0).isActive = true
        
        centerView.backgroundColor = UIColor.white
        centerView.cornerRadius = 10
        
        
        let helpIcon = UILabel()
        helpIcon.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(helpIcon)
        
        
        
        
        
        let helpBtn = UIButton()
        helpBtn.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(helpBtn)
        NSLayoutConstraint(item: helpBtn, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: helpBtn, attribute: .right, relatedBy: .equal, toItem: centerView, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: helpBtn, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        NSLayoutConstraint(item: helpBtn, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        
        
        helpBtn.cornerRadius = 10
//        helpBtn.backgroundColor = UIColor.green
        helpBtn.titleLabel?.font = UIFont(name: "IRANSansMobile-Bold", size: 16)
        helpBtn.borderWidth = 3
        helpBtn.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
        helpBtn.setTitleColor(UIColor.black, for: .normal)
        helpBtn.setTitle("   راهنمای اپلیکیشن" , for: .normal)
        helpBtn.contentHorizontalAlignment = .right
        
        
        
    
    }
    
    
}
