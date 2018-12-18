//
//  CoursesViewController.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class CoursesViewController: UIViewController {
    
    let coursesReuseIdentifier = "SB_CourseTableViewCell"
    @IBOutlet weak var courses: UITableView!
    
    var _courses = [CoursesResponseModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courses.dataSource = self
        courses.delegate = self
        
        courses.rowHeight = 140
        courses.estimatedRowHeight = UITableView.automaticDimension
        
        GetCoursesRequest()
        
    }
    
    func GetCoursesRequest() {
        
        _ProgressIndicatorManger.showProgressHUD()
        
        let _URL = "\(UtilityAPIHost.HOST)\(UtilityAPIHost.COURSES)"
        print("url = \(_URL)")
        let _headers: HTTPHeaders = [:]
        let _parameters: Parameters = [:]
        
        _APIRequestManger.APIRequestManger2(_url: _URL, method: HTTPMethod.get, parameters: _parameters, headers: _headers) { (response) in
            if let _courses = [CoursesResponseModel].deserialize(from: response as? String) {
                self._courses.removeAll()
                _courses.forEach({ (course) in
                    self._courses.append(course!)
                })
            }
            
            _ProgressIndicatorManger.dismissProgressHUD()
            self.courses.reloadData()
        }
        
    }
    
}

extension CoursesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _courses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let courseTableViewCell = courses.dequeueReusableCell(withIdentifier: coursesReuseIdentifier, for: indexPath) as! CourseTableViewCell
        
        let _course = _courses[indexPath.row]
        
        courseTableViewCell.courseDescription.text = _course.CouseDesc
        courseTableViewCell.courseImage.sd_setImage(with: URL(string: _course.CouseImage ?? ""), placeholderImage: UIImage())
        courseTableViewCell.courseName.text = _course.CouseName
        
        courseTableViewCell.courseOpenPDF.tag = indexPath.row
        courseTableViewCell.courseOpenPDF.addTarget(self, action: #selector(CoursesViewController.OpenPDF(_:)), for: .touchUpInside)
        
        return courseTableViewCell
    }
    
    @objc
    func OpenPDF(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pDFViewController = storyboard.instantiateViewController(withIdentifier :"SB_PDFViewController") as! PDFViewController
        let _course = _courses[sender.tag]
        if let pdfURL = _course.pdfURL {
            pDFViewController._url = pdfURL
        }
        self.navigationController?.pushViewController(pDFViewController, animated: true)
        
    }
    
}

