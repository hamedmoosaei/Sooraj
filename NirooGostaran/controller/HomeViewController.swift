//
//  HomeViewController.swift
//  NirooGostaran
//
//  Created by Hamed Moosaei on 12/12/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import ImageSlideshow
import Toast_Swift

class HomeViewController: UIViewController {

    let topView: UIImageView = UIImageView()
    var slider: ImageSlideshow = ImageSlideshow()
    let form1View: UIImageView = UIImageView()
    let form2View: UIImageView = UIImageView()
    let form3View: UIImageView = UIImageView()
    let layerLeftView: UIImageView = UIImageView()
    let layerCenterView: UIImageView = UIImageView()
    let layerRightView: UIImageView = UIImageView()
    let leftButton: UIButton = UIButton()
    let centerButton: UIButton = UIButton()
    let rightButton: UIButton = UIButton()
    
    let insideText3: UILabel = UILabel()
    
    var sliders = [Slider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        defaultInit()
        // Do any additional setup after loading the view.
        
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
        topViewinit(titleString: "نیروگستران")

        view.backgroundColor = UIColor.black
        for v in [slider, form1View, form2View, form3View, layerLeftView, layerCenterView, layerRightView, leftButton, centerButton, rightButton] as [UIView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(v)
        }
        
        NSLayoutConstraint(item: slider, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: slider, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: slider, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.235, constant: 0).isActive = true
        
        
        slider.slideshowInterval = 5
        slider.contentScaleMode = .scaleToFill
        slider.activityIndicator = DefaultActivityIndicator()
        slider.isUserInteractionEnabled = true
        slider.borderColor = UIColor.white
        slider.borderWidth = 4
        slider.cornerRadius = 5
        Utility.getRequest(view: view, methodName: "application/slideshow", header: false)
        { (result) in
            let jsonArray = result["results"].arrayValue
            var images = [InputSource]()
            for json in jsonArray{
                self.sliders.append(Slider(id: json["id"].intValue, title: json["description"].stringValue, image: json["image"].stringValue, link: ""))
                images.append(AlamofireSource(urlString: json["image"].stringValue)!)
                
            }
            self.slider.setImageInputs(images)
        }
        
        
        NSLayoutConstraint(item: form1View, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: form1View, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: form1View, attribute: .top, relatedBy: .equal, toItem: slider, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: form1View, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.083, constant: 0).isActive = true
        
        form1View.image = UIImage(named: "form1")
        form1View.contentMode = .scaleToFill
        form1View.layer.cornerRadius = 5
        form1View.clipsToBounds = true
        form1View.tag = 4
        form1View.isUserInteractionEnabled = true
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        form1View.addGestureRecognizer(tapGestureRecognizer4)
        
        let insideImage1 : UIImageView = UIImageView()
        let insideText1: UILabel = UILabel()
        
        insideImage1.translatesAutoresizingMaskIntoConstraints = false
        insideText1.translatesAutoresizingMaskIntoConstraints = false
        form1View.addSubview(insideImage1)
        form1View.addSubview(insideText1)
        
        NSLayoutConstraint(item: insideImage1, attribute: .right, relatedBy: .equal, toItem: form1View, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: insideImage1, attribute: .centerY, relatedBy: .equal, toItem: form1View, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideImage1, attribute: .height, relatedBy: .equal, toItem: form1View, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: insideImage1, attribute: .width, relatedBy: .equal, toItem: form1View, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        
        insideImage1.image = UIImage(named: "insideForm1")
        
        NSLayoutConstraint(item: insideText1, attribute: .right, relatedBy: .equal, toItem: insideImage1, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: insideText1, attribute: .centerY, relatedBy: .equal, toItem: form1View, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        insideText1.text = "مشاهده اطلاعات گارانتی"
        insideText1.font = UIFont(name: "IRANSansMobile", size: 14)
        insideText1.textColor = UIColor.white
        
        NSLayoutConstraint(item: form2View, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: form2View, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: form2View, attribute: .top, relatedBy: .equal, toItem: form1View, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: form2View, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.083, constant: 0).isActive = true
        
        form2View.image = UIImage(named: "form2")
        form2View.contentMode = .scaleToFill
        form2View.layer.cornerRadius = 5
        form2View.clipsToBounds = true
        form2View.tag = 5
        form2View.isUserInteractionEnabled = true
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        form2View.addGestureRecognizer(tapGestureRecognizer5)

        let insideImage2 : UIImageView = UIImageView()
        let insideText2: UILabel = UILabel()
        
        insideImage2.translatesAutoresizingMaskIntoConstraints = false
        insideText2.translatesAutoresizingMaskIntoConstraints = false
        form2View.addSubview(insideImage2)
        form2View.addSubview(insideText2)
        
        NSLayoutConstraint(item: insideImage2, attribute: .right, relatedBy: .equal, toItem: form2View, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: insideImage2, attribute: .centerY, relatedBy: .equal, toItem: form2View, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideImage2, attribute: .height, relatedBy: .equal, toItem: form2View, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: insideImage2, attribute: .width, relatedBy: .equal, toItem: form2View, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        
        insideImage2.image = UIImage(named: "insideForm2")
        
        NSLayoutConstraint(item: insideText2, attribute: .right, relatedBy: .equal, toItem: insideImage2, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: insideText2, attribute: .centerY, relatedBy: .equal, toItem: form2View, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        insideText2.text = "فعالسازی گارانتی"
        insideText2.font = UIFont(name: "IRANSansMobile", size: 14)
        insideText2.textColor = UIColor.white
        
        
        
        NSLayoutConstraint(item: form3View, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: form3View, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.95, constant: 0).isActive = true
        NSLayoutConstraint(item: form3View, attribute: .top, relatedBy: .equal, toItem: form2View, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: form3View, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.083, constant: 0).isActive = true
        
        form3View.image = UIImage(named: "form3")
        form3View.contentMode = .scaleToFill
        form3View.layer.cornerRadius = 5
        form3View.clipsToBounds = true
        form3View.tag = 6
        form3View.isUserInteractionEnabled = true
        let tapGestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        form3View.addGestureRecognizer(tapGestureRecognizer6)
        
        let insideImage3 : UIImageView = UIImageView()
        
        
        insideImage3.translatesAutoresizingMaskIntoConstraints = false
        insideText3.translatesAutoresizingMaskIntoConstraints = false
        form3View.addSubview(insideImage3)
        form3View.addSubview(insideText3)
        
        NSLayoutConstraint(item: insideImage3, attribute: .right, relatedBy: .equal, toItem: form3View, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: insideImage3, attribute: .centerY, relatedBy: .equal, toItem: form3View, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideImage3, attribute: .height, relatedBy: .equal, toItem: form3View, attribute: .height, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: insideImage3, attribute: .width, relatedBy: .equal, toItem: form3View, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        
        insideImage3.image = UIImage(named: "insideForm3")
        
        NSLayoutConstraint(item: insideText3, attribute: .right, relatedBy: .equal, toItem: insideImage3, attribute: .left, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: insideText3, attribute: .centerY, relatedBy: .equal, toItem: form3View, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        insideText3.text = "مرجوع کردن باتری"
        insideText3.font = UIFont(name: "IRANSansMobile", size: 14)
        insideText3.textColor = UIColor.white
        
        
        NSLayoutConstraint(item: layerLeftView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: self.view.frame.width * 0.025).isActive = true
        NSLayoutConstraint(item: layerLeftView, attribute: .top, relatedBy: .equal, toItem: form3View, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: layerLeftView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: layerLeftView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        
        layerLeftView.image = UIImage(named: "layerLeft")
        layerLeftView.contentMode = .scaleToFill
        layerLeftView.layer.cornerRadius = 5
        layerLeftView.clipsToBounds = true
        layerLeftView.tag = 1
        layerLeftView.isUserInteractionEnabled = true
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        layerLeftView.addGestureRecognizer(tapGestureRecognizer1)
        
        let insideLayerLeft : UIImageView = UIImageView()
        
        insideLayerLeft.translatesAutoresizingMaskIntoConstraints = false
        layerLeftView.addSubview(insideLayerLeft)
        
        NSLayoutConstraint(item: insideLayerLeft, attribute: .centerX, relatedBy: .equal, toItem: layerLeftView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerLeft, attribute: .centerY, relatedBy: .equal, toItem: layerLeftView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerLeft, attribute: .height, relatedBy: .equal, toItem: layerLeftView, attribute: .height, multiplier: 0.366, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerLeft, attribute: .width, relatedBy: .equal, toItem: layerLeftView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        
        insideLayerLeft.image = UIImage(named: "insideLayerLeft")
        insideLayerLeft.contentMode = .scaleAspectFit
        
        NSLayoutConstraint(item: layerCenterView, attribute: .left, relatedBy: .equal, toItem: layerLeftView, attribute: .right, multiplier: 1, constant: self.view.frame.width * 0.025).isActive = true
        NSLayoutConstraint(item: layerCenterView, attribute: .top, relatedBy: .equal, toItem: form3View, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: layerCenterView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: layerCenterView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        
        layerCenterView.image = UIImage(named: "layerCenter")
        layerCenterView.contentMode = .scaleToFill
        layerCenterView.layer.cornerRadius = 5
        layerCenterView.clipsToBounds = true
        layerCenterView.tag = 2
        layerCenterView.isUserInteractionEnabled = true
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        layerCenterView.addGestureRecognizer(tapGestureRecognizer2)
        
        let insideLayerCenter : UIImageView = UIImageView()
        
        insideLayerCenter.translatesAutoresizingMaskIntoConstraints = false
        layerCenterView.addSubview(insideLayerCenter)
        
        NSLayoutConstraint(item: insideLayerCenter, attribute: .centerX, relatedBy: .equal, toItem: layerCenterView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerCenter, attribute: .centerY, relatedBy: .equal, toItem: layerCenterView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerCenter, attribute: .height, relatedBy: .equal, toItem: layerCenterView, attribute: .height, multiplier: 0.366, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerCenter, attribute: .width, relatedBy: .equal, toItem: layerCenterView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        
        insideLayerCenter.image = UIImage(named: "insideLayerCenter")
        insideLayerCenter.contentMode = .scaleAspectFit
        
        
        NSLayoutConstraint(item: layerRightView, attribute: .left, relatedBy: .equal, toItem: layerCenterView, attribute: .right, multiplier: 1, constant: self.view.frame.width * 0.025).isActive = true
        NSLayoutConstraint(item: layerRightView, attribute: .top, relatedBy: .equal, toItem: form3View, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: layerRightView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: layerRightView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        
        layerRightView.image = UIImage(named: "layerRight")
        layerRightView.contentMode = .scaleToFill
        layerRightView.layer.cornerRadius = 5
        layerRightView.clipsToBounds = true
        layerRightView.tag = 3
        layerRightView.isUserInteractionEnabled = true
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        layerRightView.addGestureRecognizer(tapGestureRecognizer3)
        
        let insideLayerRight : UIImageView = UIImageView()
        
        insideLayerRight.translatesAutoresizingMaskIntoConstraints = false
        layerRightView.addSubview(insideLayerRight)
        
        NSLayoutConstraint(item: insideLayerRight, attribute: .centerX, relatedBy: .equal, toItem: layerRightView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerRight, attribute: .centerY, relatedBy: .equal, toItem: layerRightView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerRight, attribute: .height, relatedBy: .equal, toItem: layerRightView, attribute: .height, multiplier: 0.366, constant: 0).isActive = true
        NSLayoutConstraint(item: insideLayerRight, attribute: .width, relatedBy: .equal, toItem: layerRightView, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        
        insideLayerRight.image = UIImage(named: "insideLayerRight")
        insideLayerRight.contentMode = .scaleAspectFit
        
        
        
        NSLayoutConstraint(item: leftButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: self.view.frame.width * 0.025).isActive = true
        NSLayoutConstraint(item: leftButton, attribute: .top, relatedBy: .equal, toItem: layerLeftView, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: leftButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.042, constant: 0).isActive = true
        NSLayoutConstraint(item: leftButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        
        leftButton.backgroundColor = UIColor.white
        leftButton.setTitleColor(.black , for: .normal)
        leftButton.cornerRadius = 17
        leftButton.setTitle( "مطالب آموزشی", for: .normal)
        leftButton.titleLabel?.textAlignment = .center
        leftButton.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 11)
        leftButton.tag = 1
        leftButton.addTarget(self, action: #selector(HomeViewController.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        NSLayoutConstraint(item: centerButton, attribute: .left, relatedBy: .equal, toItem: leftButton, attribute: .right, multiplier: 1, constant: self.view.frame.width * 0.025).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .top, relatedBy: .equal, toItem: layerLeftView, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.042, constant: 0).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        
        centerButton.backgroundColor = UIColor.white
        centerButton.setTitleColor(.black , for: .normal)
        centerButton.cornerRadius = 17
        centerButton.setTitle("درباره نیروگستران", for: .normal)
        centerButton.titleLabel?.textAlignment = .center
        centerButton.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 11)
        centerButton.tag = 2
        centerButton.addTarget(self, action: #selector(HomeViewController.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        NSLayoutConstraint(item: rightButton, attribute: .left, relatedBy: .equal, toItem: centerButton, attribute: .right, multiplier: 1, constant: self.view.frame.width * 0.025).isActive = true
        NSLayoutConstraint(item: rightButton, attribute: .top, relatedBy: .equal, toItem: layerLeftView, attribute: .bottom, multiplier: 1, constant: self.view.frame.height * 0.012820).isActive = true
        NSLayoutConstraint(item: rightButton, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.042, constant: 0).isActive = true
        NSLayoutConstraint(item: rightButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.3, constant: 0).isActive = true
        
        rightButton.backgroundColor = UIColor.white
        rightButton.setTitleColor(.black , for: .normal)
        rightButton.cornerRadius = 17
        rightButton.setTitle("فروشگاه و خدمات", for: .normal)
        rightButton.titleLabel?.textAlignment = .center
        rightButton.titleLabel?.font = UIFont(name: "IRANSansMobile", size: 11)
        rightButton.tag = 3
        rightButton.addTarget(self, action: #selector(HomeViewController.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        
    }
    @objc func buttonTapped(_ sender:UIButton ){
        switch sender.tag {
        case 1:
            self.performSegue(withIdentifier: "Learning", sender: self)
        case 2:
            self.performSegue(withIdentifier: "About", sender: self)
        case 3:
            self.performSegue(withIdentifier: "Shop", sender: self)
        default:
            print("Oops")
        }
    }
    @objc func imageTapped(sender: UITapGestureRecognizer)
    {
        switch sender.view?.tag {
        case 1:
            self.performSegue(withIdentifier: "Learning", sender: self)
        case 2:
            self.performSegue(withIdentifier: "About", sender: self)
        case 3:
            self.performSegue(withIdentifier: "Shop", sender: self)
        case 4:
            self.performSegue(withIdentifier: "WarrantyInfo", sender: self)
        case 5:
            self.performSegue(withIdentifier: "WarrantyActivate", sender: self)
        case 6:
            let groupID = UserDefaults.standard.object(forKey: "groupId") as? Int
            print(groupID)
            if groupID == 1 {
                self.performSegue(withIdentifier: "BatteryReturn", sender: self)
            }else{
                insideText3.text = "این بخش برای سرویس کاران است"
                insideText3.textColor = UIColor.red
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: insideText3.center.x - 3, y: insideText3.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: insideText3.center.x + 3, y: insideText3.center.y))
                
                insideText3.layer.add(animation, forKey: "position")
            }
        default:
            print("Oops")
        }
    }
}
