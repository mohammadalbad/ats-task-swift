//
//  CoursesResponseModel.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import Foundation
import HandyJSON

class CoursesResponseModel: HandyJSON {
    
    required init() {}
    
    var CouseID: String?
    var UserID: String?
    var CouseName: String?
    var CouseDesc: String?
    var CouseImage: String?
    var pdfURL: String?

}
