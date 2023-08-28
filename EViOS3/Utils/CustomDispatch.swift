//
//  CustomDispatch.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation

class CustomDispatch {
    
    enum CustomQueue: String {
        case delay = "delayed"
    }
    
    static func delayed(delay: Double, completion: @escaping () -> ()) {
        let thread = DispatchQueue(label: CustomQueue.delay.rawValue)
        thread.asyncAfter(deadline: .now() + delay) {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}
