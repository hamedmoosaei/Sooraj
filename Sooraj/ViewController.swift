//
//  ViewController.swift
//  Sooraj
//
//  Created by Hamed Moosaei on 9/4/18.
//  Copyright © 2018 Hamed Moosaei. All rights reserved.
//

import UIKit
import Alamofire

@IBDesignable
class DesignableTextField: UITextField {
}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

class ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var soorajIcon: UIImageView!
    
    @IBOutlet weak var mobileBtn: DesignableButton!
    @IBOutlet weak var mobileText: DesignableTextField!
    @IBOutlet weak var mobileLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileText.delegate = self
        soorajIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        self.comeUpanimation()
    }
    
    func checkErrors(){
        if mobileText.text?.count != 11 {
            mobileLabel.textColor = UIColor.red
            mobileText.borderColor = UIColor.red
            mobileLabel.text = "لطفا شماره خود را به درستی وارد نمایید."
        }
    }
    ////////joooooon
    @IBAction func buttonTapped(_ sender: Any) {
        checkErrors()
    }
    
    private func comeUpanimation(){
        UIView.animate(withDuration: 2, delay: 0, options: [ .curveEaseOut ], animations: {
            self.mobileLabel.transform = CGAffineTransform(translationX: 0, y: -200)
            self.mobileText.transform = CGAffineTransform(translationX: 0, y: -200)
            self.mobileBtn.transform = CGAffineTransform(translationX: 0, y: -200)
        }, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
        if mobileText.placeholder == "— — — — —"{
            mobileText.placeholder = ""
            mobileBtn.isEnabled = true
            mobileBtn.alpha = 1
        }
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250 , up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
}


