//
//  EndPoints.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation

enum API: String {
    case coincap = "https://api.coincap.io/v2/assets"
    case coinstats = "https://api.coinstats.app/public/v1/coins?skip=0&limit=50&currency=EUR"
}

class EndPoints {
    static let assets = API.coincap.rawValue
    
    static func history(id: String) -> String {
        return API.coincap.rawValue + "/\(id)/history?interval=d1"
    }
    
    static let illustrate = API.coinstats.rawValue
}
