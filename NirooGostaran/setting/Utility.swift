//
//  Utility.swift
//  My Mayor
//
//  Created by Mohammad Dvarpanah on 5/29/17.
//  Copyright © 2017 Mohammad Dvarpanah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class Utility {
    
    public static func getRequest(view: UIView, methodName: String, header: Bool, completionHandler: @escaping (JSON) -> Void) -> Void {
//        print(methodName)
        view.makeToastActivity(.center)
        
        var headers: HTTPHeaders? = nil
        if(header && UserDefaults.standard.object(forKey: "token") != nil){
            headers = ["Authorization" :  UserDefaults.standard.string(forKey: "token")!]
        }
        
        Alamofire.request(Const.BASE_URL + methodName, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                if(json["error"].stringValue.contains("توکن معتبر نیست")){
//                    getRequest(view: view, methodName: "auth/token", header: true){
//                        (result) in
//                        if(!result["error"].exists()){
//                            UserDefaults.standard.set(result["token"].stringValue, forKey: Const.CONF_ACCOUNT_TOKEN)
//                            getRequest(view: view, methodName: methodName, header: header){
//                                (result) in
//                                view.hideToastActivity()
//                                completionHandler(result)
//                            }
//                        }
//                        else if(result["error"].stringValue.contains("توکن ارسالی معتبر نیست و یا بلاک شده است")) {
//                            view.hideToastActivity()
////                            showAlert(viewController: view.viewController()!, text: "لطفا مجددا وارد شوید!")
//                        }
//                    }
//                }
//                else{
                    view.hideToastActivity()
//                    if(json["error"].exists()){
//                        if(!json["error"].stringValue.contains("نام کاربری یا رمز عبور اشتباه است") && !json["error"]["mobile"][0].stringValue.contains("mobile استفاده شده تکراری می باشد.") && !json["error"].stringValue.contains("سرویسکاری در نزدیکی شما یافت نشد")){
////                            showAlert(viewController: view.viewController()!, text: json["error"].stringValue.replacingOccurrences(of: "!", with: "") + "!")
//                        }
//                    }
                    completionHandler(json)
//                }
            case .failure( _):
                view.hideToastActivity()
                if(response.result.error?.localizedDescription.contains("offline"))!{
                    view.makeToast("عدم اتصال به شبکه!")
                }
            }
        }
    }
    
    
    public static func postRequest(view: UIView, methodName: String, parameters: [String: Any], header: Bool, completionHandler: @escaping (JSON) -> Void) -> Void {
        view.makeToastActivity(.center)
        
        var headers: HTTPHeaders? = nil
        if(header && UserDefaults.standard.object(forKey: "token") != nil){
            headers = ["Authorization" : UserDefaults.standard.string(forKey: "token")!]
        }
        
        Alamofire.request(Const.BASE_URL + methodName, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                if(json["error"].stringValue.contains("توکن معتبر نیست")){
//                    getRequest(view: view, methodName: "auth/token", header: true){
//                        (result) in
//                        if(!result["error"].exists()){
//                            UserDefaults.standard.set(result["token"].stringValue, forKey: "token")
//                            getRequest(view: view, methodName: methodName, header: header){
//                                (result) in
//                                view.hideToastActivity()
//                                completionHandler(result)
//                            }
//                        }
//                        else if(result["error"].stringValue.contains("توکن ارسالی معتبر نیست و یا بلاک شده است")) {
//                            view.hideToastActivity()
////                            showAlert(viewController: view.viewController()!, text: "لطفا مجددا وارد شوید!")
//                        }
//                    }
//                }
//                else{
                    view.hideToastActivity()
//                    if(json["error"].exists()){
//                        if(!json["error"].stringValue.contains("نام کاربری یا رمز عبور اشتباه است") && !json["error"]["mobile"][0].stringValue.contains("mobile استفاده شده تکراری می باشد.") && !json["error"].stringValue.contains("سرویسکاری در نزدیکی شما یافت نشد")){
////                            showAlert(viewController: view.viewController()!, text: json["error"].stringValue.replacingOccurrences(of: "!", with: "") + "!")
//                        }
//                    }
                    completionHandler(json)
//                }
            case .failure( _):
                view.hideToastActivity()
                if(response.result.error?.localizedDescription.contains("offline"))!{
                    view.makeToast("عدم اتصال به شبکه!")
                }
            }
        }
    }
    
    public static func showAlert(viewController: UIViewController, text: String){
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "بسیار خوب", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public static func priceSeperator(text: String) -> String{
        var text = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var i = 0
        var j = 0
        while (true){
            i -= 3
            if((text.characters.count) + (i - j) > 0){
                text.insert(",", at: text.index(text.endIndex, offsetBy: i - j))
                j += 1
            }
            else{
                break
            }
        }
        return text
    }
    
    
    public static func getRequestArrivingTime(view: UIView, fromLat: String, fromLng: String, toLat: String, toLng: String, completionHandler: @escaping (JSON) -> Void) -> Void {
        
        view.makeToastActivity(.center)
        
        let url = "http://maps.googleapis.com/maps/api/directions/json?"
            + "origin=" + fromLat + "," + fromLng
            + "&destination=" + toLat + "," + toLng
            + "&language=fa-IR"
            + "&sensor=false&units=metric&mode=" + "driving"
            + "&alternatives=false"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                view.hideToastActivity()
                let json = JSON(value)
                completionHandler(json)
            case .failure( _):
                view.hideToastActivity()
                if(response.result.error?.localizedDescription.contains("offline"))!{
                    view.makeToast("عدم اتصال به شبکه!")
                }
            }
        }
    }
    
}
