//
//  ViewController.swift
//  Sit Fit
//
//  Created by User on 2/3/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        checkIfLoggedIn()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                
                self.buttonBottomConstraint.constant = 20 + kbSize.height
                self.view.layoutIfNeeded()
            }
            
            NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
               
                    
                    self.buttonBottomConstraint.constant = 20
                    self.view.layoutIfNeeded()
            
                })
    }
    }
        @IBAction func loginRegister(sender: AnyObject) {
            
            //isLoggedIn = true
            //checkIfLoggedIn()
        
        var fieldValues: [String] = [username.text,password.text]
        
            if find(fieldValues, "") != nil {
            
            
            var alertViewController = UIAlertController(title: "You Suck!", message: "All fields must be filled in Idiot!", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertViewController.addAction(defaultAction)
            presentViewController(alertViewController, animated: true, completion: nil)
            
            
        } else {
            
            println("You are logged in")
            
            var userQuery = PFUser.query()
            
            userQuery.whereKey("username", equalTo: username.text)
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    
                    self.login()
                    
                }else{
                    
                    self.signUp()
                }
                
            })
            
            //signUp()
            
        }
        
        
    }
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                
                println("Logged in as \(user)")
                // Do stuff after successful login.
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    
    func signUp() {
        
        var user = PFUser()
        user.username = username.text
        user.password = password.text
        //user.email = emailField.text
        //other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                
                println(user)
                
                self.username.text = ""
                self.password.text = ""
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
                //self.emailField.text = ""
                
                
                // Hooray! Let them use the app now.
            } else {
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
        
        
        
    }
    
    
    var isLoggedIn: Bool{
        
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("is logged in")
        }
    
        set {
            
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "is logged in")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func checkIfLoggedIn() {
        
        if isLoggedIn {
            
            var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
            
            // replace with view controller with
        }
    }
    
}//end



