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
        
        //if mapUserArray.count != 0 {
        
        for user in mapUserArray {
            var latitude: CLLocationDegrees = user.latitude
            var longitude: CLLocationDegrees  = user.longitude
            var latDelta:CLLocationDegrees = 0.01
            var longDelta:CLLocationDegrees = 0.01
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            var region:MKCoordinateRegion = MKCoordinateRegionMake (location, span)
            mapView.setRegion(region, animated:true)
            var annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = user.name
            annotation.subtitle = user.annotationURL
            mapView.addAnnotation(annotation)
        }
        
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            app.openURL(NSURL(string: annotationView.annotation.subtitle!)!)
        }
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
