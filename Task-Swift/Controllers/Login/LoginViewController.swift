//
//  LoginViewController.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let userDefaults = UserDefaults.standard

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let _user = userDefaults.string(forKey: "user")
        if let user = LoginResponseModel.deserialize(from: _user) {
            print("user: \(user)") // MARK: - this is line will be deleted later.
            OpenUserCourses(animated: false)
        }
        
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
        guard let userNameValue = userName.text, userNameValue.count > 0 else {
            _ = userName.becomeFirstResponder()
            return
        }
        
        guard let passwordValue = password.text, passwordValue.count > 0 else {
            _ = password.becomeFirstResponder()
            return
        }
        
        LoginRequest(userNameValue: userNameValue, passwordValue: passwordValue)
        
    }
    
    func LoginRequest(userNameValue: String, passwordValue: String){
        
        userName.resignFirstResponder()
        password.resignFirstResponder()
        
        _ProgressIndicatorManger.showProgressHUD()
      
        let _URL = "\(UtilityAPIHost.HOST)\(UtilityAPIHost.LOGIN)?username=\(userNameValue)&password=\(passwordValue)"
        print("url = \(_URL)")
        let _headers: HTTPHeaders = [:]
        let _parameters: Parameters = [:]
        
        _APIRequestManger.APIRequestManger2(_url: _URL, method: HTTPMethod.get, parameters: _parameters, headers: _headers) { (response) in
            if let user = [LoginResponseModel].deserialize(from: response as? String) {
                
                // MARK: if you want to use the data we can by doing this :
                // user[0]?.FullName
                
                if user.count != 0 {
                    self.userDefaults.set(user[0]?.toJSONString(), forKey: "user")
                    _ProgressIndicatorManger.dismissProgressHUD()
                    self.OpenUserCourses(animated: true)
                } else {
                    self.OpenAlert()
                }
                
            }
        }
        
    }
    
    
    // Mark: we can make the alert shared later on.
    func OpenAlert() {
        // MARK: we can localize text later.
        let alert = UIAlertController(title: "", message: "Incorrect User Name or password !", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func OpenUserCourses(animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let coursesViewController = storyboard.instantiateViewController(withIdentifier :"SB_CoursesViewController") as! CoursesViewController
        self.navigationController?.pushViewController(coursesViewController, animated: animated)
    }
    
}

