//
//  VenuesTableViewController.swift
//  Sit Fit
//
//  Created by User on 2/5/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit
import CoreLocation

var onceToken: dispatch_once_t = 0

class VenuesTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    var lmanager = CLLocationManager()
    var foundVenues: [AnyObject] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lmanager.requestWhenInUseAuthorization()
        lmanager.delegate = self
        lmanager.startUpdatingLocation()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

    
    
    dispatch_once(&onceToken) { () -> Void in
    println(locations.last)
    
    if let location = locations.last as? CLLocation {
    
    self.foundVenues = FourSquareRequest.requestVenuesWithLocation(location)
    self.tableView.reloadData()
    
    
    let venues = FourSquareRequest.requestVenuesWithLocation(location)
    
    println(venues)
    
    }
    
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return foundVenues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as UITableViewCell
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        cell.textLabel?.text = venue["name"] as? String

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
        FeedData.mainData().selectedVenue = venue
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
