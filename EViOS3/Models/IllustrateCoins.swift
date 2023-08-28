//
//  IllustrateCoins.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation

class IllustrateCoins {
    var data: [IllustrateCoin]
    
    struct IllustrateCoin: Codable {
        let name, icon : String
    }
    
    init(data: Data) {
        let decoder = JSONDecoder()
        let dataDto = try! decoder.decode(DataIllustrateCoinsDto.self, from: data)
        self.data = dataDto.coins
    }
    
    struct DataIllustrateCoinsDto: Codable {
        var coins: [IllustrateCoin]
    }
}
