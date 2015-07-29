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
        var udacityLoginOkay = true
        var httpString: String = "{\"udacity\": {\"username\": \"" + userNameText + "\", \"password\": \"" + passwordText + "\"}}"
        //var httpString: String = "{\"udacity\": {\"username\": \"cornishgiant@gmail.com\", \"password\": \"dragon\"}}"
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = httpString.dataUsingEncoding(NSUTF8StringEncoding)
        // println(request.HTTPBody)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
        if error != nil {
            udacityLoginOkay = false
        return
            }
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
            var parsingError:NSError? = nil
            let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
            if parsedResult["status"]! as! Int == 403
            {
                println("error!")
            }
            

        }
        task.resume()
        if udacityLoginOkay {
            return true
        }
        else {
            return false
        }
       }
 

    // Shared Instance
    class func sharedInstance() -> UdacityLogin {
        struct Singleton {
            static var sharedInstance = UdacityLogin()
        }
        return Singleton.sharedInstance
    }


}