//
//  MyFeedViewController.swift
//  Sit Fit
//
//  Created by User on 2/3/15.
//  Copyright (c) 2015 Greg Pachman. All rights reserved.
//

import UIKit

class MyFeedViewController: FeedTableViewController {


    override func refreshFeed() {
            
            FeedData.mainData().refreshMyFeedItems { () -> () in
                
                self.tableView.reloadData()
            }
            
        }
        
            
        }
 
 




