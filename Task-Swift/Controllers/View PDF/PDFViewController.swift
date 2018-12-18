//
//  PDFViewController.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {

    @IBOutlet weak var safariWebView: WKWebView!
    
    var _url = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url =  NSURL(string: _url) else { return }
        safariWebView.load(NSURLRequest(url: url as URL) as URLRequest)
        
    }


}
