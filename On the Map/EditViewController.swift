//
//  EditViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit
import MapKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var locationTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationTextField.delegate = self
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        let mapViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationViewController") as! NavigationViewController
        self.presentViewController(mapViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func findOnMapButton(sender: AnyObject) {
        nameLookup()
        locationFinder()
    }

    func locationFinder(){
        var localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = locationTextField.text
        println(locationTextField.text)
        var localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                var alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                alert.show()
                return
            }
            userPosting.userLocation["latitude"] = localSearchResponse.boundingRegion.center.latitude
            userPosting.userLocation["longitude"] = localSearchResponse.boundingRegion.center.longitude
            let linkViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LinkViewController") as! LinkViewController
            self.presentViewController(linkViewController, animated: true, completion: nil)
           }
    }

        func nameLookup(){
            
            let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/3903878747")!)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { data, response, error in
                if error != nil { // Handle error...
                    return
                }
                else{
                    let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
                    //println(NSString(data: newData, encoding: NSUTF8StringEncoding))
                    var parsingError:NSError? = nil
                    let parsedResult = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &parsingError) as! NSDictionary
                    //println(parsedResult)
                    var parsedDictionary2 = parsedResult["user"] as! NSDictionary
                    var parsedDictionary3:String = parsedDictionary2["nickname"] as! String
                    println(parsedDictionary3)
                    userPosting.userProperties["name"] = parsedDictionary3
                 }
            }
            task.resume()

            
            
        }


}
