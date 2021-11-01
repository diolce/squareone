//
//  TabBarSquare.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 1/11/21.
//

import Foundation
import UIKit

class TabBarSquareController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "Map"), tag: 2)
        self.viewControllers![0].tabBarItem = UITabBarItem(title: "Cities", image: UIImage(named: "Cities"), tag: 1)
        var controllers = self.viewControllers
        controllers?.append(mapViewController)
        self.viewControllers = controllers
        
        setNavigationStyle()
    }
    
    func setNavigationStyle(){
        self.navigationController!.navigationBar.backgroundColor = .white
        self.navigationController!.navigationBar.isTranslucent = false
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        self.reloadInputViews()
    }
}

