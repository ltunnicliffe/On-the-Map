//
//  LoginViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/23.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//  https://docs.google.com/document/d/1tPF1tmSzVYPSbpl7_JCeMKglKMIs3dUa4OrSAKEYNAs/pub?embedded=true
// https://docs.google.com/document/d/14oMyCKfI-NCnOoaR1h7pjqDWkaOTv0lyh9drhanqrJA/pub?embedded=true

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {

    @IBOutlet var passwordText: UITextField!
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var udacityLabel: UILabel!
    @IBOutlet var goToMap: UIButton!
    @IBOutlet var facebookAlready: UILabel!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBAction func loginButton(sender: AnyObject) {
        activityIndicatorMaker()
        let stringText:String? = usernameText.text
        let stringPass:String? = passwordText.text
        let emailTest = isValidEmail(stringText!)
        let passwordTest = isPasswordValid(stringPass!)
        if emailTest == false || passwordTest == false  {
            alertViewMaker("Your email or password is incorrect.", buttonTitle: "Please try logging in again.")
        }
        else {
        let udacityLoginTest = UdacityLogin.sharedInstance().udacityLogin(stringText!, passwordText: stringPass!)
            if udacityLoginTest == false {
                alertViewMaker("The login connection has failed.", buttonTitle: "Please check your internet connection.")
            }
            else {
                loginSuccess()
            }
        }
    }
    
    func activityIndicatorMaker(){
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func alertViewMaker(alertMessage:String, buttonTitle: String){
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        let alert = UIAlertView(title: nil, message: alertMessage, delegate: self, cancelButtonTitle: buttonTitle)
        alert.show()
    }
    
    func loginSuccess(){
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        let mapViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationViewController") as! NavigationViewController
        self.presentViewController(mapViewController, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        //From StackOverflow
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func isPasswordValid(testPass:String) ->Bool {
        if testPass.isEmpty {
            return false
        }
            else {return true}
    }
    
    @IBAction func signupButton(sender: AnyObject) {
       let linkURL=NSURL(string: "http://www.udacity.com")
       UIApplication.sharedApplication().openURL(linkURL!)
            }

    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            if result.grantedPermissions.contains("email")
            {
                let udacityLoginTest = UdacityLogin.sharedInstance().udacityFacebookLogin()
                if udacityLoginTest == false {
                    alertViewMaker("The login connection has failed.", buttonTitle: "Please check your internet connection.")
                }
                else {
                    loginSuccess()
                }
                
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func facebook(){
        print("Facebook called")
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {

            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            facebookAlready.hidden = false
            goToMap.hidden = false
        }
            
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            facebookAlready.hidden = true
            goToMap.hidden = true
        }
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    
    @IBAction func goToMap(sender: AnyObject) {
        loginSuccess()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToMap.hidden = true
        facebookAlready.hidden = true
        self.passwordText.delegate = self
        self.usernameText.delegate = self
//        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        facebook()
           }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        self.view.endEditing(true)
//    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  
}

