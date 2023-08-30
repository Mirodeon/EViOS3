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
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .black
        
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    func getLineargradient(top: CGColor, bottom: CGColor, view: UIView) -> CAGradientLayer {
//        let gradient: CAGradientLayer = {
//            let gradient = CAGradientLayer()
//            gradient.colors = [top, bottom]
//            gradient.locations = [ 0.0, 0.5]
//            return gradient
//        }()
//
//        gradient.frame = view.frame
//        return gradient
//    }
//
//    func image(fromLayer layer: CALayer) -> UIImage {
//        UIGraphicsBeginImageContext(layer.frame.size)
//
//        layer.render(in: UIGraphicsGetCurrentContext()!)
//
//        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext()
//
//        return outputImage!
//    }
}
