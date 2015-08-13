//
//  mapUser.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import Foundation


class MapUser: NSObject {
    var userProperties = [String: String]()
    var userLocation = [String: Double]()

    
init(userProperties:[String: String],userLocation:[String:Double]){
        self.userProperties = userProperties
        self.userLocation = userLocation
        
    }
}
