//
//  ProfileViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/12/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import PersianDatePicker
import DropDown

class ProfileViewController: UIViewController {
    let topView: UIImageView = UIImageView()
    let scrollView: UIScrollView = UIScrollView()
    let avatarImageView = UIImageView()
    let avatarView : UIView = UIView()
    let userDeatailView : UIView = UIView()
    let contactDetailView : UIView = UIView()
    let cityDetailView : UIView = UIView()
    
    let provinceDropDown = DropDown()
    let cityDropDown = DropDown()
    
    var provinceValue = 0
    var cityValue = 0
    
    let provinceBtn = UIButton()
    let cityBtn = UIButton()
    
    var lock = 0
    var provinceArray = Array<Int>(){
        didSet {
            if provinceArray.count != 0 {
                provinceDropDown.selectRow(at: 0)
            }
            provinceBtn.setTitle(self.provinceDropDown.selectedItem, for: .normal)
            if lock == 0{
                lock = 1
                provinceValue = self.provinceArray[0]
                self.getCities(id: self.provinceValue)
            }
        }
    }
    var cityArray = Array<Int>(){
        didSet {
            if cityArray.count != 0 {
                cityDropDown.selectRow(at: 0)
            }
            cityBtn.setTitle(self.cityDropDown.selectedItem, for: .normal)
        }
    }
    
    
    
    let genderDropDown = DropDown()
    var genderValue = 0
    var genderArray = [0,1]
    
    
    let dateTextField = UITextField()
    var image : UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewinit(titleString: "پروفایل")
        hideKeyboardWhenTappedAround()
        getProvinces()
        defaultInit()
        avatarViewInit()
        userDeatailViewInit()
        contactDetailViewInit()
        cityDetailViewInit()
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        let contentWidth = scrollView.bounds.width
        let contentHeight = CGFloat(integerLiteral: 800)
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        avatarImageView.cornerRadius = avatarImageView.layer.frame.size.width / 2
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
        
    }
    
    
    func getInfo(){
        let temp = UserDefaults.standard.object(forKey: "userId") as! String
        Utility.getRequest(view: view , methodName: "users/profile/" + temp, header: false) {
            (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"].arrayValue
                for json in jsn {
                    self.provinceDropDown.dataSource.append(json["title"].stringValue)
                    self.provinceArray.append(json["id"].intValue)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    func avatarViewInit(){
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(avatarView)
        
        NSLayoutConstraint(item: avatarView, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .width, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.92, constant: 0).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        NSLayoutConstraint(item: avatarView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        
        avatarView.backgroundColor = .white
        avatarView.cornerRadius = 7
        
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarImageView)
        NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: avatarView, attribute: .width, multiplier: 0.25, constant: 0).isActive = true
        NSLayoutConstraint(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: avatarImageView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: avatarImageView, attribute: .centerY, relatedBy: .equal, toItem: avatarView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: avatarImageView, attribute: .right, relatedBy: .equal, toItem: avatarView, attribute: .right, multiplier: 1, constant: -20).isActive = true

        avatarImageView.clipsToBounds = true
        avatarImageView.borderWidth = 2
        avatarImageView.borderColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        avatarImageView.image = UIImage(named: "avatarIcon")
        avatarImageView.contentMode = .scaleToFill
        
        let namelabel = UILabel()
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(namelabel)
        NSLayoutConstraint(item: namelabel, attribute: .centerY, relatedBy: .equal, toItem: avatarView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: namelabel, attribute: .right, relatedBy: .equal, toItem: avatarImageView, attribute: .left, multiplier: 1, constant: -10).isActive = true
        namelabel.font = UIFont(name: "IRANSansMobile-Bold", size: 16)
        namelabel.text = "حامد موسایی"
        
    }
    
    func userDeatailViewInit(){
        userDeatailView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(userDeatailView)
        NSLayoutConstraint(item: userDeatailView, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: userDeatailView, attribute: .width, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.92, constant: 0).isActive = true
        NSLayoutConstraint(item: userDeatailView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: userDeatailView, attribute: .top, relatedBy: .equal, toItem: avatarView, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        
        userDeatailView.backgroundColor = .white
        userDeatailView.cornerRadius = 7
        
        let userDetailIcon = UIImageView(image :UIImage(named: "userIcon"))
        userDetailIcon.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(userDetailIcon)
        NSLayoutConstraint(item: userDetailIcon, attribute: .top, relatedBy: .equal, toItem: userDeatailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: userDetailIcon, attribute: .right, relatedBy: .equal, toItem: userDeatailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: userDetailIcon, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: userDetailIcon, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let userDetailText = UILabel()
        userDetailText.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(userDetailText)
        NSLayoutConstraint(item: userDetailText, attribute: .top, relatedBy: .equal, toItem: userDeatailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: userDetailText, attribute: .right, relatedBy: .equal, toItem: userDetailIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: userDetailText, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: userDetailText, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        userDetailText.text = "مشخصات کاربر"
        userDetailText.font = UIFont(name: "IRANSansMobile-Bold", size: 15)
        userDetailText.textAlignment = .right
        
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(nameTextField)
        NSLayoutConstraint(item: nameTextField, attribute: .top, relatedBy: .equal, toItem: userDetailText, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: nameTextField, attribute: .centerX, relatedBy: .equal, toItem: userDeatailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nameTextField, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        nameTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        nameTextField.cornerRadius = 7
        nameTextField.textAlignment = .center
        nameTextField.keyboardAppearance = .dark
        nameTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        nameTextField.placeholder = "نام"
        nameTextField.keyboardType = .default
        
        let familyTextField = UITextField()
        familyTextField.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(familyTextField)
        NSLayoutConstraint(item: familyTextField, attribute: .top, relatedBy: .equal, toItem: nameTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: familyTextField, attribute: .centerX, relatedBy: .equal, toItem: userDeatailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: familyTextField, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: familyTextField, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        familyTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        familyTextField.cornerRadius = 7
        familyTextField.textAlignment = .center
        familyTextField.keyboardAppearance = .dark
        familyTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        familyTextField.placeholder = "نام خانوادگی"
        familyTextField.keyboardType = .default
        
        
        
        let callenderIcon = UIImageView(image :UIImage(named: "calendarIcon"))
        callenderIcon.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(callenderIcon)
        NSLayoutConstraint(item: callenderIcon, attribute: .top, relatedBy: .equal, toItem: familyTextField, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: callenderIcon, attribute: .right, relatedBy: .equal, toItem: userDeatailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: callenderIcon, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: callenderIcon, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        
        let datelabel = UILabel()
        datelabel.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(datelabel)
        NSLayoutConstraint(item: datelabel, attribute: .top, relatedBy: .equal, toItem: familyTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: datelabel, attribute: .right, relatedBy: .equal, toItem: callenderIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: datelabel, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: datelabel, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
    
        //datelabel.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        datelabel.text = "تاریخ تولد"
        datelabel.font = UIFont(name: "IRANSansMobile", size: 14)
        datelabel.textAlignment = .right
        
        
        
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(dateTextField)
        NSLayoutConstraint(item: dateTextField, attribute: .top, relatedBy: .equal, toItem: familyTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: dateTextField, attribute: .right, relatedBy: .equal, toItem: datelabel, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dateTextField, attribute: .left, relatedBy: .equal, toItem: familyTextField, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dateTextField, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        dateTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        dateTextField.cornerRadius = 7
        dateTextField.textAlignment = .center
        dateTextField.keyboardAppearance = .dark
        dateTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        dateTextField.placeholder = "تاریخ تولد"
        dateTextField.keyboardType = .default
        
        
        let persianDatePicker = PersianDatePickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 250))
        persianDatePicker.style = .long
        persianDatePicker.font = UIFont(name: "IRANSansMobile", size: 14)
        dateTextField.inputView = persianDatePicker
        
        persianDatePicker.onChange = { (year, month, day) in
            self.dateTextField.text = "\(year)/\(month)/\(day)"
        }
        
        
        let genderIcon = UIImageView(image :UIImage(named: "genderIcon"))
        genderIcon.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(genderIcon)
        NSLayoutConstraint(item: genderIcon, attribute: .top, relatedBy: .equal, toItem: dateTextField, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: genderIcon, attribute: .right, relatedBy: .equal, toItem: userDeatailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: genderIcon, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: genderIcon, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        
        
        let genderlabel = UILabel()
        genderlabel.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(genderlabel)
        NSLayoutConstraint(item: genderlabel, attribute: .top, relatedBy: .equal, toItem: dateTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: genderlabel, attribute: .right, relatedBy: .equal, toItem: genderIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: genderlabel, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: genderlabel, attribute: .width, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        
        //genderlabel.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        genderlabel.text = "جنسیت"
        genderlabel.font = UIFont(name: "IRANSansMobile", size: 14)
        genderlabel.textAlignment = .right
        
        let genderBtn = UIButton()
        genderBtn.translatesAutoresizingMaskIntoConstraints = false
        userDeatailView.addSubview(genderBtn)
        NSLayoutConstraint(item: genderBtn, attribute: .top, relatedBy: .equal, toItem: dateTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: genderBtn, attribute: .right, relatedBy: .equal, toItem: genderlabel, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: genderBtn, attribute: .left, relatedBy: .equal, toItem: familyTextField, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: genderBtn, attribute: .height, relatedBy: .equal, toItem: userDeatailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        genderBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        
        genderBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        genderBtn.cornerRadius = 7
        genderBtn.titleLabel?.textAlignment = .center
        genderBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        genderDropDown.dataSource = ["مرد","زن"]
        if genderArray.count != 0 {
            genderDropDown.selectRow(at: 0)
        }
        genderBtn.setTitleColor(UIColor.black, for: .normal)
        genderBtn.setTitle(self.genderDropDown.selectedItem, for: .normal)
        genderDropDown.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        genderDropDown.textFont = UIFont(name: "IRANSansMobile", size: 14)!
        genderDropDown.selectionBackgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        DropDown.appearance().setupCornerRadius(7)
        genderDropDown.anchorView = genderBtn
        genderDropDown.direction = .bottom
        genderDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
        }
        genderDropDown.selectionAction = { (index, item) in
            genderBtn.setTitle(item, for: .normal)
            self.genderValue = self.genderArray[index]
        }
        genderBtn.addTarget(self, action: #selector(genderDropDownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        
    }
    func contactDetailViewInit(){
        
        contactDetailView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(contactDetailView)
        
        NSLayoutConstraint(item: contactDetailView, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: contactDetailView, attribute: .width, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.92, constant: 0).isActive = true
        NSLayoutConstraint(item: contactDetailView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: contactDetailView, attribute: .top, relatedBy: .equal, toItem: userDeatailView, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        
        contactDetailView.backgroundColor = .white
        contactDetailView.cornerRadius = 7
        
        let contactInfoIcon = UIImageView(image :UIImage(named: "contactIcon"))
        contactInfoIcon.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(contactInfoIcon)
        NSLayoutConstraint(item: contactInfoIcon, attribute: .top, relatedBy: .equal, toItem: contactDetailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: contactInfoIcon, attribute: .right, relatedBy: .equal, toItem: contactDetailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: contactInfoIcon, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: contactInfoIcon, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        let contactInfoText = UILabel()
        contactInfoText.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(contactInfoText)
        NSLayoutConstraint(item: contactInfoText, attribute: .top, relatedBy: .equal, toItem: contactDetailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: contactInfoText, attribute: .right, relatedBy: .equal, toItem: contactInfoIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: contactInfoText, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: contactInfoText, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        contactInfoText.text = "اطلاعات تماس"
        contactInfoText.font = UIFont(name: "IRANSansMobile-Bold", size: 15)
        contactInfoText.textAlignment = .right
        
        
        let mobileIcon = UIImageView(image :UIImage(named: "phoneNumberIcon"))
        mobileIcon.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(mobileIcon)
        NSLayoutConstraint(item: mobileIcon, attribute: .top, relatedBy: .equal, toItem: contactInfoText, attribute: .bottom, multiplier: 1, constant: 23).isActive = true
        NSLayoutConstraint(item: mobileIcon, attribute: .right, relatedBy: .equal, toItem: contactDetailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: mobileIcon, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 8).isActive = true
        NSLayoutConstraint(item: mobileIcon, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 17).isActive = true
        
        
        let mobileLabel = UILabel()
        mobileLabel.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(mobileLabel)
        NSLayoutConstraint(item: mobileLabel, attribute: .top, relatedBy: .equal, toItem: contactInfoText, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: mobileLabel, attribute: .right, relatedBy: .equal, toItem: mobileIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: mobileLabel, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: mobileLabel, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        
        //datelabel.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        mobileLabel.text = "تلفن همراه"
        mobileLabel.font = UIFont(name: "IRANSansMobile", size: 14)
        mobileLabel.textAlignment = .right
        
        
        let mobileTextField = UITextField()
        mobileTextField.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(mobileTextField)
        NSLayoutConstraint(item: mobileTextField, attribute: .top, relatedBy: .equal, toItem: contactInfoText, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: mobileTextField, attribute: .right, relatedBy: .equal, toItem: dateTextField, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mobileTextField, attribute: .left, relatedBy: .equal, toItem: dateTextField, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mobileTextField, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        mobileTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        mobileTextField.cornerRadius = 7
        mobileTextField.textAlignment = .center
        mobileTextField.keyboardAppearance = .dark
        mobileTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        mobileTextField.placeholder = "شماره موبایل"
        mobileTextField.keyboardType = .phonePad
        
        
        let phoneIcon = UIImageView(image :UIImage(named: "phoneIcon"))
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(phoneIcon)
        NSLayoutConstraint(item: phoneIcon, attribute: .top, relatedBy: .equal, toItem: mobileTextField, attribute: .bottom, multiplier: 1, constant: 18).isActive = true
        NSLayoutConstraint(item: phoneIcon, attribute: .right, relatedBy: .equal, toItem: contactDetailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: phoneIcon, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 15).isActive = true
        NSLayoutConstraint(item: phoneIcon, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        
        
        let phoneLabel = UILabel()
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(phoneLabel)
        NSLayoutConstraint(item: phoneLabel, attribute: .top, relatedBy: .equal, toItem: mobileTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: phoneLabel, attribute: .right, relatedBy: .equal, toItem: phoneIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: phoneLabel, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: phoneLabel, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        
        //datelabel.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        phoneLabel.text = "تلفن ثابت"
        phoneLabel.font = UIFont(name: "IRANSansMobile", size: 14)
        phoneLabel.textAlignment = .right
        
        
        let phoneTextField = UITextField()
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(phoneTextField)
        NSLayoutConstraint(item: phoneTextField, attribute: .top, relatedBy: .equal, toItem: mobileTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: phoneTextField, attribute: .right, relatedBy: .equal, toItem: dateTextField, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: phoneTextField, attribute: .left, relatedBy: .equal, toItem: dateTextField, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: phoneTextField, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        phoneTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        phoneTextField.cornerRadius = 7
        phoneTextField.textAlignment = .center
        phoneTextField.keyboardAppearance = .dark
        phoneTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        phoneTextField.placeholder = "شماره ثابت"
        phoneTextField.keyboardType = .phonePad
        
        
        let mailTextField = UITextField()
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.addSubview(mailTextField)
        NSLayoutConstraint(item: mailTextField, attribute: .top, relatedBy: .equal, toItem: phoneTextField, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: mailTextField, attribute: .centerX, relatedBy: .equal, toItem: contactDetailView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mailTextField, attribute: .width, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: mailTextField, attribute: .height, relatedBy: .equal, toItem: contactDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        mailTextField.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        mailTextField.cornerRadius = 7
        mailTextField.textAlignment = .center
        mailTextField.keyboardAppearance = .dark
        mailTextField.font = UIFont(name: "IRANSansMobile", size: 14)
        mailTextField.placeholder = "پست الکترونیک"
        mailTextField.keyboardType = .emailAddress
        
    }
    
    func cityDetailViewInit() {
        cityDetailView.translatesAutoresizingMaskIntoConstraints = false
        image.addSubview(cityDetailView)
        
        
        NSLayoutConstraint(item: cityDetailView, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cityDetailView, attribute: .width, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.92, constant: 0).isActive = true
        NSLayoutConstraint(item: cityDetailView, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 0.4, constant: 0).isActive = true
        NSLayoutConstraint(item: cityDetailView, attribute: .top, relatedBy: .equal, toItem: contactDetailView, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        
        cityDetailView.backgroundColor = .white
        cityDetailView.cornerRadius = 7
        
        let homeAddressIcon = UIImageView(image :UIImage(named: "cityIcon"))
        homeAddressIcon.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.addSubview(homeAddressIcon)
        NSLayoutConstraint(item: homeAddressIcon, attribute: .top, relatedBy: .equal, toItem: cityDetailView, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: homeAddressIcon, attribute: .right, relatedBy: .equal, toItem: cityDetailView, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: homeAddressIcon, attribute: .width, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0, constant: 25).isActive = true
        NSLayoutConstraint(item: homeAddressIcon, attribute: .height, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0, constant: 26).isActive = true
        
        let homeAddressText = UILabel()
        homeAddressText.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.addSubview(homeAddressText)
        NSLayoutConstraint(item: homeAddressText, attribute: .top, relatedBy: .equal, toItem: cityDetailView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: homeAddressText, attribute: .right, relatedBy: .equal, toItem: homeAddressIcon, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: homeAddressText, attribute: .width, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: homeAddressText, attribute: .height, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0, constant: 16).isActive = true
        homeAddressText.text = "محل سکونت"
        homeAddressText.font = UIFont(name: "IRANSansMobile-Bold", size: 15)
        homeAddressText.textAlignment = .right
        
        
        
        let provinceLabel = UILabel()
        provinceLabel.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.addSubview(provinceLabel)
        NSLayoutConstraint(item: provinceLabel, attribute: .top, relatedBy: .equal, toItem: homeAddressText, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: provinceLabel, attribute: .right, relatedBy: .equal, toItem: cityDetailView, attribute: .right, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: provinceLabel, attribute: .height, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: provinceLabel, attribute: .width, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        
        //datelabel.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        provinceLabel.text = "استان"
        provinceLabel.font = UIFont(name: "IRANSansMobile", size: 14)
        provinceLabel.textAlignment = .right
        
        
        
        
        
        
        
        
        provinceBtn.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.addSubview(provinceBtn)
        NSLayoutConstraint(item: provinceBtn, attribute: .top, relatedBy: .equal, toItem: homeAddressText, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: provinceBtn, attribute: .right, relatedBy: .equal, toItem: dateTextField, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: provinceBtn, attribute: .left, relatedBy: .equal, toItem: dateTextField, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: provinceBtn, attribute: .height, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        
        provinceBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        
        provinceBtn.cornerRadius = 7
        provinceBtn.titleLabel?.textAlignment = .center
        provinceBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        
        //genderDropDown.dataSource = ["مرد","زن"]
        if provinceArray.count != 0 {
            provinceDropDown.selectRow(at: 0)
        }
        provinceBtn.setTitleColor(UIColor.black, for: .normal)
        provinceBtn.setTitle(self.provinceDropDown.selectedItem, for: .normal)
        provinceDropDown.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        provinceDropDown.textFont = UIFont(name: "IRANSansMobile", size: 14)!
        provinceDropDown.selectionBackgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        DropDown.appearance().setupCornerRadius(7)
        provinceDropDown.anchorView = provinceBtn
        provinceDropDown.direction = .bottom
        provinceDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
        }
        provinceDropDown.selectionAction = { (index, item) in
            self.cityArray.removeAll()
            self.cityDropDown.dataSource.removeAll()
            self.provinceBtn.setTitle(item, for: .normal)
            self.provinceValue = self.provinceArray[index]
            self.getCities(id: self.provinceValue)
        }
        provinceBtn.addTarget(self, action: #selector(provinceDropDownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        
        
        
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.addSubview(cityLabel)
        NSLayoutConstraint(item: cityLabel, attribute: .top, relatedBy: .equal, toItem: provinceBtn, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: cityLabel, attribute: .right, relatedBy: .equal, toItem: cityDetailView, attribute: .right, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: cityLabel, attribute: .height, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: cityLabel, attribute: .width, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.2, constant: 0).isActive = true
        
        //datelabel.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        cityLabel.text = "شهر"
        cityLabel.font = UIFont(name: "IRANSansMobile", size: 14)
        cityLabel.textAlignment = .right
        
        
        
        
        
        cityBtn.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.addSubview(cityBtn)
        NSLayoutConstraint(item: cityBtn, attribute: .top, relatedBy: .equal, toItem: provinceBtn, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: cityBtn, attribute: .right, relatedBy: .equal, toItem: dateTextField, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cityBtn, attribute: .left, relatedBy: .equal, toItem: dateTextField, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cityBtn, attribute: .height, relatedBy: .equal, toItem: cityDetailView, attribute: .width, multiplier: 0.1, constant: 0).isActive = true
        
        cityBtn.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        
        cityBtn.cornerRadius = 7
        cityBtn.titleLabel?.textAlignment = .center
        cityBtn.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 14)
        
        //genderDropDown.dataSource = ["مرد","زن"]
        if cityArray.count != 0 {
            cityDropDown.selectRow(at: 0)
        }
        cityBtn.setTitleColor(UIColor.black, for: .normal)
        cityBtn.setTitle(self.cityDropDown.selectedItem, for: .normal)
        cityDropDown.backgroundColor = UIColor(red: 238/255.0, green: 242/255.0, blue: 236/255.0, alpha: 1)
        cityDropDown.textFont = UIFont(name: "IRANSansMobile", size: 14)!
        cityDropDown.selectionBackgroundColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        DropDown.appearance().setupCornerRadius(7)
        cityDropDown.anchorView = provinceBtn
        cityDropDown.direction = .bottom
        cityDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
        }
        cityDropDown.selectionAction = { (index, item) in
            self.cityBtn.setTitle(item, for: .normal)
            self.cityValue = self.cityArray[index]
        }
        cityBtn.addTarget(self, action: #selector(cityDropDownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        
    }
    
    
    
    
    func getProvinces(){
        Utility.getRequest(view: view , methodName: "locations/provinces/83", header: false) {
            (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"].arrayValue
                for json in jsn {
                    self.provinceDropDown.dataSource.append(json["title"].stringValue)
                    self.provinceArray.append(json["id"].intValue)
                }
            }
        }
    }
    
    func getCities(id : Int){
        
        Utility.getRequest(view: view , methodName: "locations/cities/" + String(id), header: false) {
            (result) in
            if (result["success"].intValue == 1)
            {
                let jsn = result["results"].arrayValue
                for json in jsn {
                    self.cityDropDown.dataSource.append(json["title"].stringValue)
                    self.cityArray.append(json["id"].intValue)
                }
            }
        }
    }
    
    
    
    @objc func genderDropDownButtonTapped(_ sender:UIButton ){
        genderDropDown.show()
        //        sender.setTitle(dropDown.selectedItem, for: .normal)
    }
    @objc func provinceDropDownButtonTapped(_ sender:UIButton ){
        provinceDropDown.show()
        //        sender.setTitle(dropDown.selectedItem, for: .normal)
    }
    
    @objc func cityDropDownButtonTapped(_ sender:UIButton ){
        cityDropDown.show()
        //        sender.setTitle(dropDown.selectedItem, for: .normal)
    }
    
    @objc func dismissKeyboard(_ gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
}
