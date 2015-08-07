//
//  mapUser.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation


class MapUser: NSObject {
//    var name: String
//    var longitude: Double
//    var latitude: Double
//    var annotationURL: String
    
    var userProperties = [String: String]()
    var userLocation = [String: Double]()

    
    
    
//     init(name: String, longitude:Double, latitude:Double, annotationURL:String){
    init(userProperties:[String: String],userLocation:[String:Double]){
        self.userProperties = userProperties
        self.userLocation = userLocation
        
    }
//        self.name = name
//        self.longitude = longitude
//        self.latitude = latitude
//        self.annotationURL = annotationURL
    

    
}
