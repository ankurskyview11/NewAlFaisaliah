//
//  TabbarController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 11/08/21.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabBar.backgroundColor = .clear
        tabBar.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        tabBar.layer.shadowRadius = 40.0
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.6
        tabBar.layer.borderWidth = 0.4
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
    

   

}
