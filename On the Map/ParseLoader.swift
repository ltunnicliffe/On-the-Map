//
//  ParseLoader.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation



var mapUserArray = [MapUser]()
var userPosting = MapUser()




class ParseLoader: NSObject {
    
    
    
    
    func parseLogin() -> Bool {
        var parseSuccess:Bool = true
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                parseSuccess = false
                return
            }
            else{
                var parsingError:NSError? = nil
                let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                var parsedDictionary2 = parsedResult["results"] as! NSArray
                for stringName in parsedDictionary2 {
                    var firstName: String = stringName["firstName"] as! String
                    var lastName: String = stringName["lastName"] as! String
                    var nameCombo = firstName + " " + lastName
                    var newLongitude = stringName["longitude"] as! Double
                    var newLatitude = stringName["latitude"] as! Double
                    var newURL = stringName["mediaURL"] as! String
                    var newUser = MapUser()
                    newUser.name = nameCombo
                    newUser.longitude = newLongitude
                    newUser.latitude = newLatitude
                    newUser.annotationURL = newURL
                    mapUserArray.append(newUser)
                }
            }
            
        }
        task.resume()
        return parseSuccess
    }
    
    
    // Shared Instance
    class func sharedInstance() -> ParseLoader {
        struct Singleton {
            static var sharedInstance = ParseLoader()
        }
        return Singleton.sharedInstance
    }


}