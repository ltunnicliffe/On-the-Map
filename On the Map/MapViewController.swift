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
        println("mapUserInfo: \(mapUserArray)")

        var parseLoginTest = ParseLoader.sharedInstance().parseLogin()
        userCreator()
           }
    
 //   override func viewDidAppear(animated: true) {
    override func viewDidAppear(animated: Bool) {
        userCreator()

    }

    
    func userCreator (){
        var annotations = [MKPointAnnotation]()

        for user in mapUserArray {
            println("userInfo: \(user)")
            var latitude: CLLocationDegrees = user.userLocation["latitude"]!
            var longitude: CLLocationDegrees  = user.userLocation["longitude"]!
            var latDelta:CLLocationDegrees = 0.01
            var longDelta:CLLocationDegrees = 0.01
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            var region:MKCoordinateRegion = MKCoordinateRegionMake (location, span)
            mapView.setRegion(region, animated:true)
            var annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = user.userProperties["name"]
            annotation.subtitle = user.userProperties["annotationURL"]
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
        
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        println("View for annotation on.")
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == annotationView.rightCalloutAccessoryView {
            let linkURL=NSURL(string: annotationView.annotation.subtitle!)
            UIApplication.sharedApplication().openURL(linkURL!)
        }
    }
    



}
