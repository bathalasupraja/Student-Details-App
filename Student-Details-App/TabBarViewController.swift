//
//  TabBarViewController.swift
//  Student-Details-App
//
//  Created by Supraja on 26/03/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    static func create() -> TabBarViewController? {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
