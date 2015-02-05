//
//  FourSquareRequest.swift
//  Maps
//
//  Created by User on 2/2/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit
import CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "L4WMBCRNBUHQQBLXZNCC2RK2EAVTDMT3IQOLVKOHBRLYFD0S"
let CLIENT_SECRET = "ZQNZBQOI34GK2LNYUOBUOM0Q30SUOKZJYKXOM5UBEE342QCS"

class FourSquareRequest: NSObject {
    
    class func requestVenuesWithLocation(location: CLLocation) ->[AnyObject] {
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
            println(requestString)
        
        
        if let url = NSURL(string: requestString){
        
            let request = NSURLRequest(URL: url)
        
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
        
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    let venues = responseInfo["venues"] as [AnyObject]
                    
                    return venues
                }
            
            }
        
        }
        
        return []
    }
   
}
