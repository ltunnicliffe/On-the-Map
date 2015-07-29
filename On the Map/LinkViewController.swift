//
//  LinkViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit
import MapKit

class LinkViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {

    @IBOutlet var linkTextField: UITextField!
    
    var appDelegate: AppDelegate!

    
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.linkTextField.delegate = self
        
        
        var latitude: CLLocationDegrees =  userPosting.latitude!
        var longitude: CLLocationDegrees  =  userPosting.longitude!
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake (location, span)
        mapView.setRegion(region, animated:true)
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    

    @IBAction func cancelButton(sender: AnyObject) {
        
        let navigationViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationViewController") as! NavigationViewController
        self.presentViewController(navigationViewController, animated: true, completion: nil)
        

    }
    
    
    @IBAction func submitLink(sender: AnyObject) {
        userPosting.annotationURL = linkTextField.text        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var postString: String = "{\"uniqueKey\": \"1234\", \"firstName\": \"" + userPosting.name! + "\", \"lastName\": \"Tate\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"" + userPosting.annotationURL! + "\""
        var postString2: String = ",\"latitude\":" + String(stringInterpolationSegment: userPosting.latitude!) + ", \"longitude\":" + String(stringInterpolationSegment: userPosting.latitude!) + "}"
        var completeString: String = postString + postString2
        
        request.HTTPBody = completeString.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        
        
        
        
        let mapViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationViewController") as! NavigationViewController
        self.presentViewController(mapViewController, animated: true, completion: nil)
        
    }
    

}
