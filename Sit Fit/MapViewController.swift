//
//  MapViewController.swift
//  Sit Fit
//
//  Created by User on 2/5/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit
import MapKit

class MyPointAnnotation: MKPointAnnotation {
    
    var index: Int = 0
}

class MapViewController: UIViewController, MKMapViewDelegate {

    
    
    @IBOutlet weak var myMapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.delegate = self

        }
    
    func refreshFeed() {
        
        FeedData.mainData().refreshFeedItems { () -> () in
            
        
            self.createAnnotationsWithSeats(FeedData.mainData().feedItems)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshFeed()
    }
    
    func createAnnotationsWithSeats(seats: [PFObject]) {
        
        for (i,seat) in enumerate(seats){
            
            let venue = seat["venue"] as [String:AnyObject]
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat,lng)
            let annotation = MyPointAnnotation()
            annotation.index = i
            annotation.setCoordinate(coordinate)
            annotation.title = seat["name"] as String
            myMapView.addAnnotation(annotation)
            
            
            
            
        }
        
        
        
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnn")
        
        var rightArrowButton = ArrowButton(frame:CGRectMake(0, 0, 22, 22))
        
        rightArrowButton.strokeSize = 2
        rightArrowButton.leftInset = 8
        rightArrowButton.rightInset = 8
        rightArrowButton.topInset = 5
        rightArrowButton.bottomInset = 5
        
        
        annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
        
        annotationView.canShowCallout = true
        
        return annotationView
        
        
    }
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!){
        
        
        let index = (view.annotation as MyPointAnnotation).index
        
        FeedData.mainData().selectedSeat = FeedData.mainData().feedItems[index]
        
        
        var detailVC = storyboard?.instantiateViewControllerWithIdentifier("seatDetailVC") as UIViewController
        navigationController?.pushViewController(detailVC, animated: true)
        
        
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
