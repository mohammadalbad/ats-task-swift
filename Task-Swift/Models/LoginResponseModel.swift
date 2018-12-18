//
//  LoginResponseModel.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import Foundation
import HandyJSON

class LoginResponseModel: HandyJSON {
    
    required init() {}
    
    var ID: String?
    var FullName: String?
    var UserName: String?
    var Password: String?

}
