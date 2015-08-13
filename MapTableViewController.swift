//
//  MapTableViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("tableview array: \(mapUserArray)")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapUserArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        var cellFiller = mapUserArray[indexPath.row]
        
        if cellFiller.userProperties.isEmpty {
             cell.textLabel?.text = "Empty"
        } else {
            cell.textLabel?.text = cellFiller.userProperties["name"]
    }
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       

        
        
        var arraySelector = mapUserArray[indexPath.row]
        if arraySelector.userProperties.isEmpty{
            return
        }
        else {
            var linkToUse = arraySelector.userProperties["annotationURL"]
            let linkURL = NSURL(string: linkToUse!)
            UIApplication.sharedApplication().openURL(linkURL!)
      }
        
        
    }

}


