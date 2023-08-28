//
//  Coins.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation

class Coins {
    var data: [Coin]
    
    struct Coin: Codable {
        let id, rank, name, priceUsd, changePercent24Hr: String
        let explorer: String?
    }
    
    init(data: Data) {
        let decoder = JSONDecoder()
        let dataDto = try! decoder.decode(DataCoinsDto.self, from: data)
        self.data = dataDto.data
    }
    
    struct DataCoinsDto: Codable {
        var data: [Coin]
    }
    
}
