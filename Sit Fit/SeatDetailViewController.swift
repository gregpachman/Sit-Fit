//
//  SeatDetailViewController.swift
//  Sit Fit
//
//  Created by User on 2/6/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit

class SeatDetailViewController: UIViewController {

    @IBOutlet weak var seatImageView: UIImageView!
    
    @IBOutlet weak var seatNameLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seatNameLabel.text = FeedData.mainData().selectedSeat?["name"] as? String

        // Do any additional setup after loading the view.
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
