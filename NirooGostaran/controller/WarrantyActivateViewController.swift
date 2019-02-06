//
//  WarrantyActivateViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/15/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import DropDown

class WarrantyActivateViewController: UIViewController , UITextFieldDelegate {
    
    let topView: UIImageView = UIImageView()
    let codeTextfield: UITextField = UITextField()
    let scrollView: UIScrollView = UIScrollView()
    var image : UIImageView = UIImageView()
    var detailView = UIView()
    var errorView = UIView()
    var activateView = UIView()
    let mobileTextField = UITextField()
    let ageDropDown = DropDown()
    let carTypeDropDown = DropDown()
    let carPlateTypeDropDown = DropDown()
    
    var carPlateTypeValue = 0
    var carTypeValue = 0
    var carAgeValue = 0
    
    var ageArray = Array<Int>()
    var carTypeArray = Array<Int>()
    var carPlateTypeArray = Array<Int>()
    
    var productId = 0
    
    let startWarrantyValue = UILabel()
    let stopWarrantyValue = UILabel()
    let statusValue = UILabel()
    let producerValue = UILabel()
    let brandValue = UILabel()
    let amperValue = UILabel()
    
    let irTextField = UITextField()
    let rightTextField = UITextField()
    let centerTextField = UITextField()
    let leftTextField = UITextField()
    
    let arrowDown1 = UIImageView(image: UIImage(named: "downIcon"))
    let arrowDown2 = UIImageView(image: UIImage(named: "downIcon"))
    let arrowDown3 = UIImageView(image: UIImage(named: "downIcon"))
    
    var textFieldCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        topViewinit(titleString: "فعالسازی گارانتی")
        getYears()
        getCarTypes()
        getCarPlateTypes()
        defaultInit()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let contentWidth = scrollView.bounds.width
        let contentHeight = CGFloat(integerLiteral: 1200)
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        textFieldCounter = 1
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
        topViewBtn.addTarget(self, action: #selector(WarrantyActivateViewController.backTapped(_:)), for: UIControlEvents.touchUpInside)
    }
    func defaultInit(){
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        scrollView.backgroundColor = UIColor.black
        
        
        image = UIImageView(image: UIImage(named: "blackback"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        scrollView.addSubview(image)
        NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
        // header
        let headerImageView = UIImageView(image: UIImage(named: "scan"))
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(headerImageView)
        NSLayoutConstraint(item: headerImageView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: headerImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: headerImageView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.93, constant: 0).isActive = true
        NSLayoutConstraint(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.4, constant: 0).isActive = true
        
        let tapQuickPayGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openQuickPay(_:)))
        headerImageView.isUserInteractionEnabled = true
        headerImageView.addGestureRecognizer(tapQuickPayGestureRecognizer)
        
        
        codeTextfield.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(codeTextfield)
        NSLayoutConstraint(item: codeTextfield, attribute: .top, relatedBy: .equal, toItem: headerImageView, attribute: .bottom, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: codeTextfield, attribute: .right, relatedBy: .equal, toItem: headerImageView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: codeTextfield, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.76, constant: 0).isActive = true
        NSLayoutConstraint(item: codeTextfield, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        
        codeTextfield.backgroundColor = UIColor.white
        codeTextfield.cornerRadius = 15
        codeTextfield.textAlignment = .center
        codeTextfield.keyboardAppearance = .dark
        codeTextfield.font = UIFont(name: "IRANSansMobile", size: 14)
        codeTextfield.placeholder = "کد باتری را وارد کنید"
        codeTextfield.keyboardType = .numberPad
        codeTextfield.clearButtonMode = .always
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(btn)
        
        NSLayoutConstraint(item: btn, attribute: .left, relatedBy: .equal, toItem: headerImageView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.15, constant: 0).isActive = true
        NSLayoutConstraint(item: btn, attribute: .top, relatedBy: .equal, toItem: codeTextfield, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        
        btn.backgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitle("ارسال", for: .normal)
        btn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 15)
        btn.cornerRadius = 15
        btn.addTarget(self, action: #selector(sendButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        //        view.bringSubview(toFront: headerImageView)
        //        view.bringSubview(toFront: textfield)
        //        view.bringSubview(toFront: btn)
        
    }
    func showDetailsView(){
        codeTextfield.resignFirstResponder()
        errorView.removeFromSuperview()
        detailView = UIView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(detailView)
        NSLayoutConstraint(item: detailView, attribute: .top, relatedBy: .equal, toItem: codeTextfield, attribute: .bottom, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .left, relatedBy: .equal, toItem: image, attribute: .left, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .right, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: -7).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        detailView.backgroundColor = UIColor.white
        detailView.cornerRadius = 10
        
        let titleIcon = UIImageView(image :UIImage(named: "infoIcon"))
        titleIcon.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(titleIcon)
        NSLayoutConstraint(item: titleIcon, attribute: .top, relatedBy: .equal, toItem: detailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: titleIcon, attribute: .right, relatedBy: .equal, toItem: detailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: titleIcon, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: titleIcon, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let titleText = UILabel()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(titleText)
        NSLayoutConstraint(item: titleText, attribute: .top, relatedBy: .equal, toItem: detailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: titleText, attribute: .right, relatedBy: .equal, toItem: titleIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: titleText, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: titleText, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        titleText.text = "جزئیات محصول"
        titleText.font = UIFont(name: "IRANSansMobile-Bold", size: 15)
        titleText.textAlignment = .right
        
        let backView1 = UIView()
        backView1.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(backView1)
        NSLayoutConstraint(item: backView1, attribute: .top, relatedBy: .equal, toItem: titleText, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: backView1, attribute: .centerX, relatedBy: .equal, toItem: detailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView1, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.97, constant: 0).isActive = true
        NSLayoutConstraint(item: backView1, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.15, constant: 0).isActive = true
        backView1.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        backView1.cornerRadius = 7
        
        let startCalendarIcon = UIImageView(image: UIImage(named: "calendarIcon"))
        startCalendarIcon.translatesAutoresizingMaskIntoConstraints = false
        backView1.addSubview(startCalendarIcon)
        NSLayoutConstraint(item: startCalendarIcon, attribute: .centerY, relatedBy: .equal, toItem: backView1, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: startCalendarIcon, attribute: .right, relatedBy: .equal, toItem: backView1, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: startCalendarIcon, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: startCalendarIcon, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let startWarrantyLabel = UILabel()
        startWarrantyLabel.translatesAutoresizingMaskIntoConstraints = false
        backView1.addSubview(startWarrantyLabel)
        NSLayoutConstraint(item: startWarrantyLabel, attribute: .centerY, relatedBy: .equal, toItem: backView1, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: startWarrantyLabel, attribute: .right, relatedBy: .equal, toItem: startCalendarIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: startWarrantyLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: startWarrantyLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        startWarrantyLabel.text = "تاریخ شروع گارانتی :"
        startWarrantyLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 11)
        startWarrantyLabel.textAlignment = .right
        
        startWarrantyValue.translatesAutoresizingMaskIntoConstraints = false
        backView1.addSubview(startWarrantyValue)
        NSLayoutConstraint(item: startWarrantyValue, attribute: .centerY, relatedBy: .equal, toItem: backView1, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: startWarrantyValue, attribute: .right, relatedBy: .equal, toItem: startWarrantyLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: startWarrantyValue, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.45, constant: 0).isActive = true
        NSLayoutConstraint(item: startWarrantyValue, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        //        startWarrantyValue.text = "۱۳۹۷/۱۰/۲۳ ۱۴:۳۰:۰۰"
        startWarrantyValue.font = UIFont(name: "IRANSansMobile", size: 12)
        startWarrantyValue.textAlignment = .right
        
        // next
        
        let backView2 = UIView()
        backView2.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(backView2)
        NSLayoutConstraint(item: backView2, attribute: .top, relatedBy: .equal, toItem: backView1, attribute: .bottom, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: backView2, attribute: .centerX, relatedBy: .equal, toItem: detailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView2, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.97, constant: 0).isActive = true
        NSLayoutConstraint(item: backView2, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.15, constant: 0).isActive = true
        backView2.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        backView2.cornerRadius = 7
        
        let stopCalendarIcon = UIImageView(image: UIImage(named: "calendarIcon"))
        stopCalendarIcon.translatesAutoresizingMaskIntoConstraints = false
        backView2.addSubview(stopCalendarIcon)
        NSLayoutConstraint(item: stopCalendarIcon, attribute: .centerY, relatedBy: .equal, toItem: backView2, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stopCalendarIcon, attribute: .right, relatedBy: .equal, toItem: backView2, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: stopCalendarIcon, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: stopCalendarIcon, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let stopWarrantyLabel = UILabel()
        stopWarrantyLabel.translatesAutoresizingMaskIntoConstraints = false
        backView2.addSubview(stopWarrantyLabel)
        NSLayoutConstraint(item: stopWarrantyLabel, attribute: .centerY, relatedBy: .equal, toItem: backView2, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stopWarrantyLabel, attribute: .right, relatedBy: .equal, toItem: stopCalendarIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: stopWarrantyLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: stopWarrantyLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        stopWarrantyLabel.text = "تاریخ پایان گارانتی :"
        stopWarrantyLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 11)
        stopWarrantyLabel.textAlignment = .right
        
        stopWarrantyValue.translatesAutoresizingMaskIntoConstraints = false
        backView2.addSubview(stopWarrantyValue)
        NSLayoutConstraint(item: stopWarrantyValue, attribute: .centerY, relatedBy: .equal, toItem: backView2, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stopWarrantyValue, attribute: .right, relatedBy: .equal, toItem: stopWarrantyLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: stopWarrantyValue, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.45, constant: 0).isActive = true
        NSLayoutConstraint(item: stopWarrantyValue, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        //        stopWarrantyValue.text = "۱۳۹۷/۱۰/۲۳ ۱۴:۳۰:۰۰"
        stopWarrantyValue.font = UIFont(name: "IRANSansMobile", size: 12)
        stopWarrantyValue.textAlignment = .right
        
        //next
        
        let backView3 = UIView()
        backView3.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(backView3)
        NSLayoutConstraint(item: backView3, attribute: .top, relatedBy: .equal, toItem: backView2, attribute: .bottom, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: backView3, attribute: .centerX, relatedBy: .equal, toItem: detailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView3, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.97, constant: 0).isActive = true
        NSLayoutConstraint(item: backView3, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.15, constant: 0).isActive = true
        backView3.backgroundColor = UIColor(red: 238/255.0, green: 228/255.0, blue: 179/255.0, alpha: 1)
        backView3.cornerRadius = 7
        
        let statusIcon = UIImageView(image: UIImage(named: "statusIcon"))
        statusIcon.translatesAutoresizingMaskIntoConstraints = false
        backView3.addSubview(statusIcon)
        NSLayoutConstraint(item: statusIcon, attribute: .centerY, relatedBy: .equal, toItem: backView3, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: statusIcon, attribute: .right, relatedBy: .equal, toItem: backView3, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: statusIcon, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: statusIcon, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        backView3.addSubview(statusLabel)
        NSLayoutConstraint(item: statusLabel, attribute: .centerY, relatedBy: .equal, toItem: backView3, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: statusLabel, attribute: .right, relatedBy: .equal, toItem: statusIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: statusLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: statusLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        statusLabel.text = "وضعیت محصول :"
        statusLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 11)
        statusLabel.textAlignment = .right
        
        
        statusValue.translatesAutoresizingMaskIntoConstraints = false
        backView3.addSubview(statusValue)
        NSLayoutConstraint(item: statusValue, attribute: .centerY, relatedBy: .equal, toItem: backView3, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: statusValue, attribute: .right, relatedBy: .equal, toItem: statusLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: statusValue, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: statusValue, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        //        statusValue.text = "تولید فانویه"
        statusValue.font = UIFont(name: "IRANSansMobile", size: 12)
        statusValue.textAlignment = .right
        
        // next
        
        
        let backView4 = UIView()
        backView4.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(backView4)
        NSLayoutConstraint(item: backView4, attribute: .top, relatedBy: .equal, toItem: backView3, attribute: .bottom, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: backView4, attribute: .centerX, relatedBy: .equal, toItem: detailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: backView4, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.97, constant: 0).isActive = true
        NSLayoutConstraint(item: backView4, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.4, constant: 0).isActive = true
        backView4.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        backView4.cornerRadius = 7
        
        let technicalInfoIcon = UIImageView(image: UIImage(named: "technicalIcon"))
        technicalInfoIcon.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(technicalInfoIcon)
        NSLayoutConstraint(item: technicalInfoIcon, attribute: .top, relatedBy: .equal, toItem: backView4, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: technicalInfoIcon, attribute: .right, relatedBy: .equal, toItem: backView4, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: technicalInfoIcon, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 17).isActive = true
        NSLayoutConstraint(item: technicalInfoIcon, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 17).isActive = true
        
        let technicalInfoLabel = UILabel()
        technicalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(technicalInfoLabel)
        NSLayoutConstraint(item: technicalInfoLabel, attribute: .top, relatedBy: .equal, toItem: backView4, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: technicalInfoLabel, attribute: .right, relatedBy: .equal, toItem: technicalInfoIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: technicalInfoLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: technicalInfoLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        technicalInfoLabel.text = "جزئیات فنی"
        technicalInfoLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 11)
        technicalInfoLabel.textAlignment = .right
        
        let producerLabel = UILabel()
        producerLabel.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(producerLabel)
        NSLayoutConstraint(item: producerLabel, attribute: .top, relatedBy: .equal, toItem: technicalInfoLabel, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: producerLabel, attribute: .right, relatedBy: .equal, toItem: technicalInfoIcon, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: producerLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: producerLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        producerLabel.text = "تولید کننده :"
        producerLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 10)
        producerLabel.textAlignment = .right
        
        
        producerValue.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(producerValue)
        NSLayoutConstraint(item: producerValue, attribute: .top, relatedBy: .equal, toItem: producerLabel, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: producerValue, attribute: .right, relatedBy: .equal, toItem: producerLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: producerValue, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: producerValue, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        //        producerValue.text = "عصر نقره ای"
        producerValue.font = UIFont(name: "IRANSansMobile", size: 10)
        producerValue.textAlignment = .right
        
        
        let brandLabel = UILabel()
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(brandLabel)
        NSLayoutConstraint(item: brandLabel, attribute: .top, relatedBy: .equal, toItem: producerLabel, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: brandLabel, attribute: .right, relatedBy: .equal, toItem: technicalInfoIcon, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: brandLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: brandLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        brandLabel.text = "برند :"
        brandLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 10)
        brandLabel.textAlignment = .right
        
        
        brandValue.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(brandValue)
        NSLayoutConstraint(item: brandValue, attribute: .top, relatedBy: .equal, toItem: brandLabel, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: brandValue, attribute: .right, relatedBy: .equal, toItem: brandLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: brandValue, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: brandValue, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        //        brandValue.text = "آی او اس"
        brandValue.font = UIFont(name: "IRANSansMobile", size: 10)
        brandValue.textAlignment = .right
        
        
        let amperLabel = UILabel()
        amperLabel.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(amperLabel)
        NSLayoutConstraint(item: amperLabel, attribute: .top, relatedBy: .equal, toItem: brandLabel, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: amperLabel, attribute: .right, relatedBy: .equal, toItem: technicalInfoIcon, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: amperLabel, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: amperLabel, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        amperLabel.text = "آمپراژ :"
        amperLabel.font = UIFont(name: "IRANSansMobile-Bold", size: 10)
        amperLabel.textAlignment = .right
        
        
        amperValue.translatesAutoresizingMaskIntoConstraints = false
        backView4.addSubview(amperValue)
        NSLayoutConstraint(item: amperValue, attribute: .top, relatedBy: .equal, toItem: amperLabel, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: amperValue, attribute: .right, relatedBy: .equal, toItem: amperLabel, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: amperValue, attribute: .width, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: amperValue, attribute: .height, relatedBy: .equal, toItem: detailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        //        amperValue.text = "۶۰۰۰"
        amperValue.font = UIFont(name: "IRANSansMobile", size: 10)
        amperValue.textAlignment = .right
        
    }
    func showError(str : String){
        print("show error")
        detailView.removeFromSuperview()
        activateView.removeFromSuperview()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        errorView = UIView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(errorView)
        NSLayoutConstraint(item: errorView, attribute: .top, relatedBy: .equal, toItem: codeTextfield, attribute: .bottom, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: errorView, attribute: .left, relatedBy: .equal, toItem: image, attribute: .left, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: errorView, attribute: .right, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: -7).isActive = true
        NSLayoutConstraint(item: errorView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.15, constant: 0).isActive = true
        
        errorView.backgroundColor = UIColor.white
        errorView.cornerRadius = 10
        
        let errorIcon = UIImageView(image :UIImage(named: "errorIcon"))
        errorIcon.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(errorIcon)
        NSLayoutConstraint(item: errorIcon, attribute: .centerY, relatedBy: .equal, toItem: errorView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: errorIcon, attribute: .right, relatedBy: .equal, toItem: errorView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: errorIcon, attribute: .width, relatedBy: .equal, toItem: errorView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: errorIcon, attribute: .height, relatedBy: .equal, toItem: errorView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let errorText = UILabel()
        errorText.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(errorText)
        NSLayoutConstraint(item: errorText, attribute: .centerY, relatedBy: .equal, toItem: errorView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: errorText, attribute: .right, relatedBy: .equal, toItem: errorIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: errorText, attribute: .width, relatedBy: .equal, toItem: errorView, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: errorText, attribute: .height, relatedBy: .equal, toItem: errorView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        errorText.text = str
        errorText.font = UIFont(name: "IRANSansMobile-Bold", size: 15)
        errorText.textAlignment = .right
        
    }
    
    @objc func sendButtonTapped(_ sender:UIButton ){
        if (codeTextfield.text != "") {
            getDetails()
        }
        else{
            showError(str: "لطفا کد محصول را وارد کنید")
        }
    }
    
    func getCarTypes(){
        Utility.getRequest(view: view , methodName: "car/car-types", header: false) {
            (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"]
                let ageModel = jsn["car_types"].arrayValue
                for json in ageModel {
                    self.carTypeDropDown.dataSource.append(json["title"].stringValue)
                    self.carTypeArray.append(json["id"].intValue)
                }
            }
        }
    }
    func getCarPlateTypes(){
        Utility.getRequest(view: view , methodName: "car/plaque-types", header: false) {
            (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"]
                let ageModel = jsn["plaque_types"].arrayValue
                for json in ageModel {
                    self.carPlateTypeDropDown.dataSource.append(json["title"].stringValue)
                    self.carPlateTypeArray.append(json["id"].intValue)
                }
            }
        }
    }
    func getYears(){
        Utility.getRequest(view: view , methodName: "car/cars/age-models", header: false) {
            (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"]
                let ageModel = jsn["age_models"].arrayValue
                for json in ageModel {
                    self.ageDropDown.dataSource.append(json["label"].stringValue)
                    self.ageArray.append(json["value"].intValue)
                }
            }
        }
    }
    func getDetails(){
        Utility.postRequest(view: view, methodName: "shop/products/details", parameters: ["unique_code" : codeTextfield.text!], header: true)
        { (result) in
            if (result["success"].intValue == 1)
            {
                self.showDetailsView()
                self.showActivateView()
                let jsn = result["results"]
                let json = jsn["product"]
                self.productId = json["id"].intValue
                self.startWarrantyValue.text = json["sale_date"].stringValue
                self.stopWarrantyValue.text = json["expire_date"].stringValue
                self.statusValue.text = json["status"].stringValue
                let brand = json["brand"]
                self.brandValue.text = brand["title"].stringValue
                let producer = brand["producer"]
                self.producerValue.text = producer["title"].stringValue
                let amper = json["amperage"]
                self.amperValue.text = amper["title"].stringValue
            }
            else{
                self.showError(str: result["user_message"].stringValue)
            }
        }
    }

    func showActivateView(){
        textFieldCounter = 1
        errorView.removeFromSuperview()
        activateView = UIView()
        activateView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(activateView)
        NSLayoutConstraint(item: activateView, attribute: .top, relatedBy: .equal, toItem: detailView, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: activateView, attribute: .left, relatedBy: .equal, toItem: image, attribute: .left, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: activateView, attribute: .right, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: -7).isActive = true
        NSLayoutConstraint(item: activateView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 1.3, constant: 0).isActive = true
        
        activateView.backgroundColor = UIColor.white
        activateView.cornerRadius = 10
        
        let titleIcon = UIImageView(image :UIImage(named: "warrantyIcon"))
        titleIcon.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(titleIcon)
        NSLayoutConstraint(item: titleIcon, attribute: .top, relatedBy: .equal, toItem: activateView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: titleIcon, attribute: .right, relatedBy: .equal, toItem: activateView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: titleIcon, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 17).isActive = true
        NSLayoutConstraint(item: titleIcon, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 17).isActive = true
        
        let titleText = UILabel()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(titleText)
        NSLayoutConstraint(item: titleText, attribute: .top, relatedBy: .equal, toItem: activateView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: titleText, attribute: .right, relatedBy: .equal, toItem: titleIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: titleText, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: titleText, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        titleText.text = "گارانتی"
        titleText.font = UIFont(name: "IRANSansMobile-Bold", size: 15)
        titleText.textAlignment = .right
        
        
        let phoneIcon = UIImageView(image :UIImage(named: "phoneNumberIcon"))
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(phoneIcon)
        NSLayoutConstraint(item: phoneIcon, attribute: .top, relatedBy: .equal, toItem: titleIcon, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: phoneIcon, attribute: .right, relatedBy: .equal, toItem: activateView, attribute: .right, multiplier: 1, constant: -19).isActive = true
        NSLayoutConstraint(item: phoneIcon, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 8).isActive = true
        NSLayoutConstraint(item: phoneIcon, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 17).isActive = true
        
        let phoneText = UILabel()
        phoneText.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(phoneText)
        NSLayoutConstraint(item: phoneText, attribute: .top, relatedBy: .equal, toItem: phoneIcon, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: phoneText, attribute: .right, relatedBy: .equal, toItem: phoneIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: phoneText, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: phoneText, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        phoneText.text = "شماره موبایل خود را در فیلد زیر وارد نمایید ."
        phoneText.font = UIFont(name: "IRANSansMobile", size: 12)
        phoneText.textAlignment = .right
        
        
        mobileTextField.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(mobileTextField)
        NSLayoutConstraint(item: mobileTextField, attribute: .top, relatedBy: .equal, toItem: phoneText, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: mobileTextField, attribute: .centerX, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mobileTextField, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: mobileTextField, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        mobileTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        mobileTextField.cornerRadius = 7
        mobileTextField.textAlignment = .center
        mobileTextField.keyboardAppearance = .dark
        mobileTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        mobileTextField.placeholder = "شماره موبایل"
        mobileTextField.keyboardType = .numberPad
        mobileTextField.text = UserDefaults.standard.object(forKey: "mobile") as? String
        mobileTextField.clearButtonMode = .always
        
        let calendarIcon = UIImageView(image :UIImage(named: "calendarIcon"))
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(calendarIcon)
        NSLayoutConstraint(item: calendarIcon, attribute: .top, relatedBy: .equal, toItem: mobileTextField, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: calendarIcon, attribute: .right, relatedBy: .equal, toItem: activateView, attribute: .right, multiplier: 1, constant: -19).isActive = true
        NSLayoutConstraint(item: calendarIcon, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: calendarIcon, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let carProductionYearText = UILabel()
        carProductionYearText.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carProductionYearText)
        NSLayoutConstraint(item: carProductionYearText, attribute: .top, relatedBy: .equal, toItem: calendarIcon, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carProductionYearText, attribute: .right, relatedBy: .equal, toItem: calendarIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: carProductionYearText, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carProductionYearText, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        carProductionYearText.text = "سال تولید خودرو"
        carProductionYearText.font = UIFont(name: "IRANSansMobile", size: 12)
        carProductionYearText.textAlignment = .right
        
        
        let carAgeBtn = UIButton()
        carAgeBtn.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carAgeBtn)
        NSLayoutConstraint(item: carAgeBtn, attribute: .top, relatedBy: .equal, toItem: carProductionYearText, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: carAgeBtn, attribute: .centerX, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carAgeBtn, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: carAgeBtn, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        carAgeBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        
        carAgeBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        carAgeBtn.cornerRadius = 7
        carAgeBtn.titleLabel?.textAlignment = .center
        carAgeBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        if ageArray.count != 0 {
            ageDropDown.selectRow(at: 0)
        }
        carAgeBtn.setTitleColor(UIColor.black, for: .normal)
        carAgeBtn.setTitle(self.ageDropDown.selectedItem, for: .normal)
        ageDropDown.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        ageDropDown.textFont = UIFont(name: "IRANSansMobile", size: 14)!
        ageDropDown.selectionBackgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        DropDown.appearance().setupCornerRadius(7)
        ageDropDown.anchorView = carAgeBtn
        ageDropDown.direction = .bottom
        ageDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .left
        }
        ageDropDown.selectionAction = { (index, item) in
            carAgeBtn.setTitle(item, for: .normal)
            self.carAgeValue = self.ageArray[index]
        }
        carAgeBtn.addTarget(self, action: #selector(ageDropDownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        let carTypeIcon = UIImageView(image :UIImage(named: "carTypeIcon"))
        carTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carTypeIcon)
        NSLayoutConstraint(item: carTypeIcon, attribute: .top, relatedBy: .equal, toItem: carAgeBtn, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: carTypeIcon, attribute: .right, relatedBy: .equal, toItem: activateView, attribute: .right, multiplier: 1, constant: -19).isActive = true
        NSLayoutConstraint(item: carTypeIcon, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: carTypeIcon, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let carTypeText = UILabel()
        carTypeText.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carTypeText)
        NSLayoutConstraint(item: carTypeText, attribute: .top, relatedBy: .equal, toItem: carTypeIcon, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carTypeText, attribute: .right, relatedBy: .equal, toItem: carTypeIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: carTypeText, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carTypeText, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        carTypeText.text = "نوع خودرو"
        carTypeText.font = UIFont(name: "IRANSansMobile", size: 12)
        carTypeText.textAlignment = .right
        
        
        let plateTypeIcon = UIImageView(image :UIImage(named: "plateTypeIcon"))
        plateTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(plateTypeIcon)
        NSLayoutConstraint(item: plateTypeIcon, attribute: .top, relatedBy: .equal, toItem: carAgeBtn, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: plateTypeIcon, attribute: .right, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 1, constant: -9).isActive = true
        NSLayoutConstraint(item: plateTypeIcon, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: plateTypeIcon, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let plateTypeText = UILabel()
        plateTypeText.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(plateTypeText)
        NSLayoutConstraint(item: plateTypeText, attribute: .top, relatedBy: .equal, toItem: plateTypeIcon, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: plateTypeText, attribute: .right, relatedBy: .equal, toItem: plateTypeIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: plateTypeText, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: plateTypeText, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        plateTypeText.text = "نوع پلاک خودرو"
        plateTypeText.font = UIFont(name: "IRANSansMobile", size: 12)
        plateTypeText.textAlignment = .right
        
        
        
        
        let carTypeBtn = UIButton()
        carTypeBtn.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carTypeBtn)
        NSLayoutConstraint(item: carTypeBtn, attribute: .top, relatedBy: .equal, toItem: carTypeText, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: carTypeBtn, attribute: .centerX, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 1.5, constant: 0).isActive = true
        NSLayoutConstraint(item: carTypeBtn, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.45, constant: 0).isActive = true
        NSLayoutConstraint(item: carTypeBtn, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        carTypeBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        
        carTypeBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        carTypeBtn.cornerRadius = 7
        carTypeBtn.titleLabel?.textAlignment = .center
        carTypeBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        //carTypeDropDown.dataSource = ["سواری", "کامیون", "موتورسیکلت"]
        if carTypeArray.count != 0 {
            carTypeDropDown.selectRow(at: 0)
        }
        carTypeBtn.setTitleColor(UIColor.black, for: .normal)
        carTypeBtn.setTitle(self.carTypeDropDown.selectedItem, for: .normal)
        carTypeDropDown.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        carTypeDropDown.textFont = UIFont(name: "IRANSansMobile", size: 14)!
        carTypeDropDown.selectionBackgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        DropDown.appearance().setupCornerRadius(7)
        carTypeDropDown.anchorView = carTypeBtn
        carTypeDropDown.direction = .bottom
        carTypeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
        }
        carTypeDropDown.selectionAction = { (index, item) in
            carTypeBtn.setTitle(item, for: .normal)
            self.carTypeValue = self.carTypeArray[index]
        }
        carTypeBtn.addTarget(self, action: #selector(carTypeDropDownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        let plateTypeBtn = UIButton()
        plateTypeBtn.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(plateTypeBtn)
        NSLayoutConstraint(item: plateTypeBtn, attribute: .top, relatedBy: .equal, toItem: plateTypeText, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: plateTypeBtn, attribute: .centerX, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: plateTypeBtn, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.45, constant: 0).isActive = true
        NSLayoutConstraint(item: plateTypeBtn, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        plateTypeBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        
        plateTypeBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        plateTypeBtn.cornerRadius = 7
        plateTypeBtn.titleLabel?.textAlignment = .center
        plateTypeBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        plateTypeBtn.setTitleColor(UIColor.black, for: .normal)
        //carPlateTypeDropDown.dataSource = ["دولتی", "شخصی", "سیاسی"]
        if carPlateTypeArray.count != 0 {
            carPlateTypeDropDown.selectRow(at: 0)
        }
        plateTypeBtn.setTitle(self.carPlateTypeDropDown.selectedItem, for: .normal)
        carPlateTypeDropDown.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        carPlateTypeDropDown.textFont = UIFont(name: "IRANSansMobile", size: 14)!
        carPlateTypeDropDown.selectionBackgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        DropDown.appearance().setupCornerRadius(7)
        carPlateTypeDropDown.anchorView = plateTypeBtn
        carPlateTypeDropDown.direction = .bottom
        carPlateTypeDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
        }
        carPlateTypeDropDown.selectionAction = { (index, item) in
            plateTypeBtn.setTitle(item, for: .normal)
            self.carPlateTypeValue = self.carPlateTypeArray[index]
        }
        plateTypeBtn.addTarget(self, action: #selector(carPlateTypeDropDownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        let carPlateIcon = UIImageView(image :UIImage(named: "carPlateIcon"))
        carPlateIcon.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carPlateIcon)
        NSLayoutConstraint(item: carPlateIcon, attribute: .top, relatedBy: .equal, toItem: carTypeBtn, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: carPlateIcon, attribute: .right, relatedBy: .equal, toItem: activateView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: carPlateIcon, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 20).isActive = true
        NSLayoutConstraint(item: carPlateIcon, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let carPlateText = UILabel()
        carPlateText.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(carPlateText)
        NSLayoutConstraint(item: carPlateText, attribute: .top, relatedBy: .equal, toItem: carPlateIcon, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carPlateText, attribute: .right, relatedBy: .equal, toItem: carPlateIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: carPlateText, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: carPlateText, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        carPlateText.text = "شماره پلاک خودرو"
        carPlateText.font = UIFont(name: "IRANSansMobile", size: 12)
        carPlateText.textAlignment = .right
        
        
        let plateImage = UIImageView(image: UIImage(named: "emptyPlate"))
        plateImage.translatesAutoresizingMaskIntoConstraints = false
        plateImage.isUserInteractionEnabled = true
        activateView.addSubview(plateImage)
        NSLayoutConstraint(item: plateImage, attribute: .top, relatedBy: .equal, toItem: carPlateText, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: plateImage, attribute: .centerX, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: plateImage, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: plateImage, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        
        
        irTextField.translatesAutoresizingMaskIntoConstraints = false
        plateImage.addSubview(irTextField)
        NSLayoutConstraint(item: irTextField, attribute: .centerY, relatedBy: .equal, toItem: plateImage, attribute: .centerY, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: irTextField, attribute: .right, relatedBy: .equal, toItem: plateImage, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: irTextField, attribute: .width, relatedBy: .equal, toItem: plateImage, attribute: .width, multiplier: 0.18, constant: 0).isActive = true
        NSLayoutConstraint(item: irTextField, attribute: .height, relatedBy: .equal, toItem: plateImage, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        irTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        irTextField.cornerRadius = 7
        irTextField.textAlignment = .center
        irTextField.keyboardAppearance = .dark
        irTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        irTextField.placeholder = "22"
        irTextField.keyboardType = .numberPad
        irTextField.delegate = self
        irTextField.addTarget(self, action: #selector(completeTextField(_:)), for: .editingChanged)
        
        
        
        
        
        rightTextField.translatesAutoresizingMaskIntoConstraints = false
        plateImage.addSubview(rightTextField)
        NSLayoutConstraint(item: rightTextField, attribute: .centerY, relatedBy: .equal, toItem: plateImage, attribute: .centerY, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: rightTextField, attribute: .right, relatedBy: .equal, toItem: irTextField, attribute: .left, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: rightTextField, attribute: .width, relatedBy: .equal, toItem: plateImage, attribute: .width, multiplier: 0.18, constant: 0).isActive = true
        NSLayoutConstraint(item: rightTextField, attribute: .height, relatedBy: .equal, toItem: plateImage, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        rightTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        rightTextField.cornerRadius = 7
        rightTextField.textAlignment = .center
        rightTextField.keyboardAppearance = .dark
        rightTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        rightTextField.placeholder = "342"
        rightTextField.keyboardType = .numberPad
        rightTextField.delegate = self
        rightTextField.addTarget(self, action: #selector(completeTextField(_:)), for: .editingChanged)
        
        centerTextField.translatesAutoresizingMaskIntoConstraints = false
        plateImage.addSubview(centerTextField)
        NSLayoutConstraint(item: centerTextField, attribute: .centerY, relatedBy: .equal, toItem: plateImage, attribute: .centerY, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: centerTextField, attribute: .right, relatedBy: .equal, toItem: rightTextField, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: centerTextField, attribute: .width, relatedBy: .equal, toItem: plateImage, attribute: .width, multiplier: 0.18, constant: 0).isActive = true
        NSLayoutConstraint(item: centerTextField, attribute: .height, relatedBy: .equal, toItem: plateImage, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        centerTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        centerTextField.cornerRadius = 7
        centerTextField.textAlignment = .center
        centerTextField.keyboardAppearance = .dark
        centerTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        centerTextField.placeholder = "ب"
        centerTextField.keyboardType = .default
        centerTextField.delegate = self
        centerTextField.addTarget(self, action: #selector(completeTextField(_:)), for: .editingChanged)
        
        leftTextField.translatesAutoresizingMaskIntoConstraints = false
        plateImage.addSubview(leftTextField)
        NSLayoutConstraint(item: leftTextField, attribute: .centerY, relatedBy: .equal, toItem: plateImage, attribute: .centerY, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: leftTextField, attribute: .right, relatedBy: .equal, toItem: centerTextField, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: leftTextField, attribute: .width, relatedBy: .equal, toItem: plateImage, attribute: .width, multiplier: 0.18, constant: 0).isActive = true
        NSLayoutConstraint(item: leftTextField, attribute: .height, relatedBy: .equal, toItem: plateImage, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        leftTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        leftTextField.cornerRadius = 7
        leftTextField.textAlignment = .center
        leftTextField.keyboardAppearance = .dark
        leftTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        leftTextField.placeholder = "12"
        leftTextField.keyboardType = .numberPad
        leftTextField.delegate = self
        leftTextField.addTarget(self, action: #selector(completeTextField(_:)), for: .editingChanged)
        
        let activeBtn = UIButton()
        activeBtn.translatesAutoresizingMaskIntoConstraints = false
        activateView.addSubview(activeBtn)
        NSLayoutConstraint(item: activeBtn, attribute: .centerX, relatedBy: .equal, toItem: activateView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activeBtn, attribute: .bottom, relatedBy: .equal, toItem: activateView, attribute: .bottom, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: activeBtn, attribute: .width, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: activeBtn, attribute: .height, relatedBy: .equal, toItem: activateView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        
        
        activeBtn.backgroundColor = UIColor(red: 80/255.0, green: 160/255.0, blue: 60/255.0, alpha: 1)
        activeBtn.setTitle("فعالسازی گارانتی", for: .normal)
        activeBtn.cornerRadius = 7
        activeBtn.titleLabel?.textAlignment = .center
        activeBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        activeBtn.setTitleColor(UIColor.white, for: .normal)
        
        activeBtn.addTarget(self, action: #selector(activeButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        for v in [mobileTextField,carAgeBtn,carTypeBtn,plateTypeBtn,leftTextField,centerTextField,rightTextField,irTextField]{
            v.borderWidth = 3
            v.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
        }
        carAgeBtn.addSubview(arrowDown1)
        carTypeBtn.addSubview(arrowDown2)
        plateTypeBtn.addSubview(arrowDown3)
        for v in [arrowDown1,arrowDown2,arrowDown3]{
            NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: v.superview, attribute: .left, multiplier: 1, constant: 10).isActive = true
            NSLayoutConstraint(item: v, attribute: .centerY, relatedBy: .equal, toItem: v.superview, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: v.superview, attribute: .height, multiplier: 0.3, constant: 0).isActive = true
            NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: v.superview, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @objc func completeTextField(_ sender:UITextField){
        switch sender {
        case irTextField:
            if (sender.text?.count)! >= 2 {
                
                irTextField.resignFirstResponder()
                textFieldCounter *= 7
                
            }
            break
            
        case rightTextField:
            if (sender.text?.count)! >= 3 {
                if textFieldCounter % 210 == 0{
                    rightTextField.resignFirstResponder()
                }else{
                    irTextField.becomeFirstResponder()
                    textFieldCounter *= 5
                }
            }
            break
            
        case centerTextField:
            if (sender.text?.count)! >= 1 {
                if textFieldCounter % 210 == 0{
                    centerTextField.resignFirstResponder()
                }else{
                    rightTextField.becomeFirstResponder()
                    textFieldCounter *= 3
                }
            }
            break
            
        case leftTextField:
            if (sender.text?.count)! >= 2 {
                if textFieldCounter % 210 == 0{
                    leftTextField.resignFirstResponder()
                }else{
                    centerTextField.becomeFirstResponder()
                    textFieldCounter *= 2
                }
                
            }
            break
            
        default:
            break
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func ageDropDownButtonTapped(_ sender:UIButton ){
        ageDropDown.show()
//        sender.setTitle(dropDown.selectedItem, for: .normal)
    }
    @objc func carTypeDropDownButtonTapped(_ sender:UIButton ){
        carTypeDropDown.show()
        //        sender.setTitle(dropDown.selectedItem, for: .normal)
    }
    @objc func carPlateTypeDropDownButtonTapped(_ sender:UIButton ){
        carPlateTypeDropDown.show()
        //        sender.setTitle(dropDown.selectedItem, for: .normal)
    }
    @objc func activeButtonTapped(_ sender:UIButton ){
        let plaque = leftTextField.text! + "-" + centerTextField.text! + "-" + rightTextField.text! + "-" + irTextField.text!
        
        
        let param =  ["product_id" : productId , "customer_mobile" : mobileTextField.text! , "plaque" : plaque , "plaque_type_id" : carPlateTypeValue , "car_type_id" : carTypeValue , "age_model" : carAgeValue ] as [String : Any]
        
        Utility.postRequest(view: view, methodName: "shop/products/active/warranty", parameters: param, header: true)
        { (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"]
                print(jsn)
                // hello every one lsdakjf jkf sdf 
//                let json = jsn["product"]
//                self.startWarrantyValue.text = json["sale_date"].stringValue
//                self.stopWarrantyValue.text = json["expire_date"].stringValue
//                self.statusValue.text = json["status"].stringValue
//                let brand = json["brand"]
//                self.brandValue.text = brand["title"].stringValue
//                let producer = brand["producer"]
//                self.producerValue.text = producer["title"].stringValue
//                let amper = json["amperage"]
//                self.amperValue.text = amper["title"].stringValue
            }
            else{
                self.showError(str: result["user_message"].stringValue)
            }
        }
        
        
    }
    @objc func backTapped(_ sender:UIButton ){
        //back button
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: tabBarViewController = storyboard.instantiateViewController(withIdentifier: "0") as! tabBarViewController
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    @objc func openQuickPay(_ sender:UITapGestureRecognizer){
        //ScannerViewController
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ScannerViewController = storyboard.instantiateViewController(withIdentifier: "1") as! ScannerViewController
        vc.src = "info"
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}
