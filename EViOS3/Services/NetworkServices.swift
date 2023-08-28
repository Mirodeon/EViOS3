//
//  NetworkServices.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation
import Alamofire

class NetworkServices {
    
    //assets
    typealias coinsCompletionHandler = (_ coins: Coins?, _ statusCode: Int?, _ error: Error?) -> ()
    
    static func assets(completionHandler: @escaping coinsCompletionHandler) {
        AF.request(EndPoints.assets).responseData{ (dataResponse) in
            if let error = dataResponse.error {
                completionHandler(nil, dataResponse.response?.statusCode, error)
                return
            }
            
            if let data = dataResponse.data {
                let coins = Coins(data: data)
                completionHandler(coins, nil, nil)
            } else {
                completionHandler(nil, 404, nil)
            }
        }
    }
    
    //history
    typealias historyCompletionHandler = (_ history: History?, _ statusCode: Int?, _ error: Error?) -> ()
    
    static func history(id: String, completionHandler: @escaping historyCompletionHandler) {
        AF.request(EndPoints.history(id: id)).responseData{ (dataResponse) in
            if let error = dataResponse.error {
                completionHandler(nil, dataResponse.response?.statusCode, error)
                return
            }
            
            if let data = dataResponse.data {
                let history = History(data: data)
                completionHandler(history, nil, nil)
            } else {
                completionHandler(nil, 404, nil)
            }
        }
    }
    
    //illustration
    typealias illustrateCompletionHandler = (_ illustrate: IllustrateCoins?, _ statusCode: Int?, _ error: Error?) -> ()
    
    static func illustrate(completionHandler: @escaping illustrateCompletionHandler) {
        AF.request(EndPoints.illustrate).responseData{ (dataResponse) in
            if let error = dataResponse.error {
                completionHandler(nil, dataResponse.response?.statusCode, error)
                return
            }
            
            if let data = dataResponse.data {
                let illustrate = IllustrateCoins(data: data)
                completionHandler(illustrate, nil, nil)
            } else {
                completionHandler(nil, 404, nil)
            }
        }
    }
    
}
