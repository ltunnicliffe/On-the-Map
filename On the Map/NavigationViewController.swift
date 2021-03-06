//
//  NavigationViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var appDelegate: AppDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationItems = UINavigationItem()
        navigationItems.title = "On The Map"
        let leftButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logOut")
        let rightButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refreshView")
        let rightButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "editView")
        let rightButtons = [rightButton1, rightButton2]
        navigationItems.leftBarButtonItem = leftButton
        navigationItems.rightBarButtonItems = rightButtons
        self.navigationBar.items=[navigationItems]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refreshView(){
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        ParseLoader.sharedInstance().parseLogin()
        
    }
    
    func editView(){
       let editViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EditViewController") as! EditViewController
            self.presentViewController(editViewController, animated: true, completion: nil)
    }
    
    
    
    func logOut(){
        
        print("Logout worked!!!")
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        
        for cookie in (sharedCookieStorage.cookies )! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        
   
        
        let logInViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(logInViewController, animated: true, completion: nil)

        
    }
    
    

}
