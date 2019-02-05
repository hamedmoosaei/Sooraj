//
//  LearningViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/15/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit

class LearningViewController: UIViewController {
    let topView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewinit(titleString: "مطالب آموزشی")
        defaultInit()
    }

    func topViewinit(titleString: String){
        let right = UISwipeGestureRecognizer(target : self, action : #selector(backTapped(_:)))
        right.direction = .right
        self.view.addGestureRecognizer(right)
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
        
        let topViewBtn: UIButton = UIButton()
        topViewBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topViewBtn)
        
        NSLayoutConstraint(item: topViewBtn, attribute: .left , relatedBy: .equal, toItem: topView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topViewBtn, attribute: .bottom, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topViewBtn, attribute: .width, relatedBy: .equal, toItem: topView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: topViewBtn, attribute: .height, relatedBy: .equal, toItem: topView, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        
        let btnImage = UIImage(named: "lefting")
        topViewBtn.setImage(btnImage , for: UIControlState.normal)
        topViewBtn.addTarget(self, action: #selector(LearningViewController.backTapped(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func defaultInit(){
        
        let image = UIImageView(image: UIImage(named: "blackback"))
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
        let commingSoonImage = UIImageView(image: UIImage(named: "soon"))
        commingSoonImage.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(commingSoonImage)
        NSLayoutConstraint(item: commingSoonImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: commingSoonImage, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: commingSoonImage, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.98, constant: 0).isActive = true
        NSLayoutConstraint(item: commingSoonImage, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.55, constant: 0).isActive = true
        
        
        
        
    }
    
    @objc func backTapped(_ sender:UIButton ){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
