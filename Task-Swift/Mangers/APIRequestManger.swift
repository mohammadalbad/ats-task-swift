//
//  APIRequestManger.swift
//  Task-Swift
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

import Foundation
import Alamofire

let _APIRequestManger = APIRequestManger()

class APIRequestManger {
    
    // MARK: - This is for JSON Request Body Row Format
    func APIRequestManger(_url: String, method: HTTPMethod, jsonRequestPayload: String, headers: HTTPHeaders, completion: @escaping (_ response: Any?) -> ()) {
        
        var _request = URLRequest(url: URL(string: _url)!)
        _request.httpMethod = method.rawValue
        _request.allHTTPHeaderFields = headers
        let _data = jsonRequestPayload.data(using: .utf8)
        _request.httpBody = _data
        Alamofire.request(_request).responseJSON { (response) in
            if response.error != nil {
                // MARK : - We can handle this later on.
                return
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                completion(utf8Text)
            }
            
        }
        
    }
    
    // MARK: - This is for JSON Request Body Params Format
    func APIRequestManger2(_url: String, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders,encoding:ParameterEncoding = URLEncoding.default, completion: @escaping (_ response: Any?) -> ()) {
        
        Alamofire.request(_url, method: method, parameters: parameters,encoding:encoding, headers: headers).responseJSON { (response) in
            
            if response.error != nil {
                // MARK : - We can handle this later on.
                return
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                completion(utf8Text)
            }

        }
        
    }
    
    
}

