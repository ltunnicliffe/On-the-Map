//
//  LoginViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/23.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordText: UITextField!
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var udacityLabel: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBAction func loginButton(sender: AnyObject) {
        activityIndicatorMaker()
//        var stringText:String = usernameText.text
//        var stringPass:String = passwordText.text
        var stringText:String = "cornishgiant@gmail.com"
        var stringPass:String = "dragon"
        var emailTest = isValidEmail(stringText)
        var passwordTest = isPasswordValid(stringPass)
        if emailTest == false || passwordTest == false  {
            alertViewMaker("Your email or password is incorrect.", buttonTitle: "Please try logging in again.")
        }
        else {
        var udacityLoginTest = UdacityLogin.sharedInstance().udacityLogin(stringText, passwordText: stringPass)
            if udacityLoginTest == false {
                alertViewMaker("The login connection has failed.", buttonTitle: "Please check your internet connection.")
            }
            else {
                var parseLoginTest = ParseLoader.sharedInstance().parseLogin()
                if parseLoginTest == false {
                    alertViewMaker("The login connection has failed.", buttonTitle: "Please check your internet connection.")
                }
                else {
                   loginSuccess()
                }
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
        var alert = UIAlertView(title: nil, message: alertMessage, delegate: self, cancelButtonTitle: buttonTitle)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordText.delegate = self
        self.usernameText.delegate = self
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  
}

