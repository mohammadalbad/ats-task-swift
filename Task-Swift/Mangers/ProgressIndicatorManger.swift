//
//  ProgressIndicatorManger.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import Foundation
import MBProgressHUD

let _ProgressIndicatorManger = ProgressIndicatorManger()

class ProgressIndicatorManger {
    
    func showProgressHUD() {
        if let window = UIApplication.shared.windows.last {
            MBProgressHUD.showAdded(to: window, animated: true)
        }
    }
    
    func dismissProgressHUD() -> Void {
        if let window = UIApplication.shared.windows.last {
            MBProgressHUD.hide(for: window, animated: true)
        }
    }
    
}

