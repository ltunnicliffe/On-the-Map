//
//  NavigationViewController.swift
//  On the Map
//
//  Created by Luke on 2015/07/28.
//  Copyright (c) 2015年 Luke Tunnicliffe. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationItems = UINavigationItem()
        navigationItems.title = "On The Map"
        let leftButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        let rightButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: nil)
        let rightButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: nil)
        let rightButtons = [rightButton1, rightButton2]
        navigationItems.leftBarButtonItem = leftButton
        navigationItems.rightBarButtonItems = rightButtons
        self.navigationBar.items=[navigationItems]
        
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
