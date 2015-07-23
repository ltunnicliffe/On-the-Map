//
//  ViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/23.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   
    
    @IBOutlet var passwordText: UITextField!
    
    
    @IBOutlet var usernameText: UITextField!
    
    
    

    
    
    
    
    @IBOutlet var udacityLabel: UILabel!
    
    
    
    
    
    @IBAction func loginButton(sender: AnyObject) {
     
    
        
        var stringText:String = usernameText.text
        
        var stringPass:String = passwordText.text
        
        var httpString: String = "{\"udacity\": {\"" + stringText + "\": \"account@domain.com\", \""+stringPass+"\": \"********\"}}"
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = httpString.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            println(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        
        
        
        
        
    self.performSegueWithIdentifier("tabViewController", sender: nil)

        
    }
    
    
    @IBAction func signupButton(sender: AnyObject) {
       let linkURL=NSURL(string: "http://www.udacity.com")
       UIApplication.sharedApplication().openURL(linkURL!)
            }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
        
    }
    

    
    
    
    
    
    


}

