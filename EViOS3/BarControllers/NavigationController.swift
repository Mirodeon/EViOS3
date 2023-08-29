//
//  NavigationController.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .black
        
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .white
    }
}
