//
//  UdacityLogin.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation



class UdacityLogin: NSObject {
    
    func udacityLogin(userNameText: String, passwordText:String) -> Bool {
        //Create URL
        var httpString: String = "{\"udacity\": {\"username\": \"" + userNameText + "\", \"password\": \"" + passwordText + "\"}}"
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = httpString.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { data, response, downloadError in
            if let error = downloadError {
                dispatch_async(dispatch_get_main_queue()) {
                    return false
                }
            } else {
                 /* 5. Parse the data */
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                println("This is the Udacity data \(NSString(data: newData, encoding: NSUTF8StringEncoding))")
                var parsingError:NSError? = nil
                let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                 /* 6. Use the data! */
                if parsingError != nil {
                    println("Failed to parse data.")
                }
                else {
                    println(parsedResult)
                }
            }

        }
        task.resume()
        //return "Okay"
        
        return true
      
       }
 

    
    func udacityFacebookLogin()->Bool{
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"facebook_mobile\": {\"access_token\": \"DADFMS4SN9e8BAD6vMs6yWuEcrJlMZChFB0ZB0PCLZBY8FPFYxIPy1WOr402QurYWm7hj1ZCoeoXhAk2tekZBIddkYLAtwQ7PuTPGSERwH1DfZC5XSef3TQy1pyuAPBp5JJ364uFuGw6EDaxPZBIZBLg192U8vL7mZAzYUSJsZA8NxcqQgZCKdK4ZBA2l2ZA6Y1ZBWHifSM0slybL9xJm3ZBbTXSBZCMItjnZBH25irLhIvbxj01QmlKKP3iOnl8Ey;\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, downloadError in
            if let error = downloadError {
                dispatch_async(dispatch_get_main_queue()) {
                    return false
                }
            }else {
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            println("This is the Udacity data \(NSString(data: newData, encoding: NSUTF8StringEncoding))")
                var parsingError:NSError? = nil
                let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                /* 6. Use the data! */
                if parsingError != nil {
                    println("Failed to parse data.")
                }
                else {
                    println(parsedResult)
                }
        }
        }
        task.resume()
         return true
    }

    // Shared Instance
    class func sharedInstance() -> UdacityLogin {
        struct Singleton {
            static var sharedInstance = UdacityLogin()
        }
        return Singleton.sharedInstance
    }


}