//
//  CustomLoader.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation
import UIKit

class CustomLoader {
    
    var loader = UIActivityIndicatorView()
    
    init(color: UIColor, view: UIView){
        loader.frame = view.bounds
        loader.backgroundColor = UIColor(named: "Opacity5")
        loader.style = .large
        loader.isHidden = true
        loader.color = color
        loader.center = view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        view.bringSubviewToFront(loader)
    }
}
