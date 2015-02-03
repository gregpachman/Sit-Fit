//
//  NewSeatViewController.swift
//  Sit Fit
//
//  Created by User on 2/3/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit

class NewSeatViewController: UIViewController {

    @IBOutlet weak var seatNameField: UITextField!
    
    // var seats: [PFObjects]?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func cancelSeat(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        FeedData.mainData().feedItems.append(newSeat)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
