//
//  AboutNirooGostaranViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/15/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue],documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
class AboutNirooGostaranViewController: UIViewController {
    let topView: UIImageView = UIImageView()
    
    let scrollView:UIScrollView = UIScrollView()
    let headerImageView:UIImageView = UIImageView()
    
    let titleLabel:UILabel = UILabel()
    let descriptionTextView:UILabel = UILabel()
    
    var content:String = String(){
        didSet{
            titleLabel.text = "درباره ما"
            descriptionTextView.text = content.html2String
            updateWithSpacing(lineSpacing: 12)
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 19
//            let atributes = [NSAttributedString.Key.paragraphStyle: style ]
//            descriptionTextView.attributedText = NSAttributedString(string: descriptionTextView.text, attributes: atributes)
        }
    }
    func updateWithSpacing(lineSpacing: Float) {
        // The attributed string to which the
        // paragraph line spacing style will be applied.
        let attributedString = NSMutableAttributedString(string: descriptionTextView.text!)
        let mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(lineSpacing)
        
        if let stringLength = descriptionTextView.text?.characters.count {
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        descriptionTextView.attributedText = attributedString
        descriptionTextView.textAlignment = .right
        // currentValueLabel is the label which displays
        // the  current value of UISlider (Which in turn is the line spacing).
        // This can be changed on the fly by sliding the UISlider.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewinit(titleString: "درباره نیروگستران")
        defaultInit()
        loadAboutUs()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let contentWidth = scrollView.bounds.width
        let contentHeight = CGFloat(integerLiteral: 1200)
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    func loadAboutUs(){
        Utility.getRequest(view: view, methodName: "application/usual/about-us", header: false)
        { (result) in
            let json = result["results"]
            self.content = json["content"].stringValue
        }
    }

    
    func defaultInit(){
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        scrollView.backgroundColor = UIColor.black
        
        let image = UIImageView(image: UIImage(named: "blackback"))
        image.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(image)
        NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        for v in [headerImageView, titleLabel, descriptionTextView] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            image.addSubview(v)
        }
        
        // header
        NSLayoutConstraint(item: headerImageView, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: headerImageView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: headerImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.4, constant: 0).isActive = true
        headerImageView.image = UIImage(named: "aboutHeader")
        
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.headerImageView, attribute: .bottom, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 20).isActive = true
        titleLabel.font = UIFont(name: "IRANSansMobile", size: 18)
        titleLabel.textAlignment = .right
        titleLabel.textColor = UIColor(red: 200/255.0, green: 170/255.0, blue: 80/255.0, alpha: 1)
        
        NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: descriptionTextView, attribute: .right, relatedBy: .equal, toItem: self.titleLabel, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: descriptionTextView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 30).isActive = true
        
        descriptionTextView.font = UIFont(name: "IRANSansMobile", size: 14)
        descriptionTextView.textColor = UIColor.white
        descriptionTextView.backgroundColor = .clear
//        descriptionTextView.textAlignment = .right
        
        //descriptionTextView.textAlignment = .justified
//        descriptionTextView.isScrollEnabled = false
        descriptionTextView.sizeToFit()
        descriptionTextView.numberOfLines = 0
//        descriptionTextView.isEditable = false
        
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
        topViewBtn.addTarget(self, action: #selector(AboutNirooGostaranViewController.backTapped(_:)), for: UIControlEvents.touchUpInside)
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

