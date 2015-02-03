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
            
            isLoggedIn = true
            
            checkIfLoggedIn()
        
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
    
}



