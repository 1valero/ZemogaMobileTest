//
//  Services.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import Foundation

class Services {
    
    static func requestArray(url:String,method:String, json: [String: Any]? = nil, completion: @escaping ([AnyObject])-> ()){
        let urlString = URL(string: url)!
        var request = URLRequest(url: urlString)
        request.httpMethod = method
        
        if method == Constants.POST {
            let data = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = data
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error  in
            guard let data = data, error == nil else {
                Utils.dump(text: "No data")
                completion([])
                return
            }
            
            let response = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response = response as? [AnyObject]{
                completion(response)
            }
        })
        task.resume()
    }
    
    static func requestObject(url:String,method:String, json: [String: Any]? = nil, completion: @escaping ([String : Any])-> ()){
        let urlString = URL(string: url)!
        var request = URLRequest(url: urlString)
        request.httpMethod = method
        
        if method == Constants.POST {
            let data = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = data
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error  in
            guard let data = data, error == nil else {
                Utils.dump(text: "No data")
                return
            }
            
            let response = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response = response as? [String: Any]{
                completion(response)
            }
        })
        task.resume()
    }

}
