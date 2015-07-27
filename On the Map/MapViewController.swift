//
//  MapViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/23.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseLogin()
        
       
        
        
        
        
        var latitude: CLLocationDegrees = 60.7
        var longitude: CLLocationDegrees  = -73.9
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake (location, span)
        mapView.setRegion(region, animated:true)
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "Niagra Falls"
        
        annotation.subtitle = "One day I'll go here..."
        
        mapView.addAnnotation(annotation)

        
        
        
        
        var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "action:")
        longPressRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPressRecognizer)
        
    }
    
    
    
    func parseLogin(){
    
    let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, error in
        if error != nil { // Handle error...
            return
        }
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
    }
    task.resume()
        
        }

    
    
    
    
    
    
    
    
    
    
    
    

    func action (gestureRecognizer: UIGestureRecognizer) {
        println("pressed!")
    
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        var newCoordinate: CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)

        var myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = newCoordinate
        myAnnotation.title = "Annotation Title"
        myAnnotation.subtitle = "I would like to go here!"
        mapView.addAnnotation(myAnnotation)

        

    }


    



}
