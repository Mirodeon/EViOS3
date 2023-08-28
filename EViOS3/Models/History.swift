//
//  History.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import Foundation

class History {
    var data: [Record]
    
    struct Record: Codable {
        let priceUsd: String
        let time: Double
        let date: String
    }
    
    init(data: Data) {
        let decoder = JSONDecoder()
        let dataDto = try! decoder.decode(DataHistoryDto.self, from: data)
        self.data = dataDto.data
    }
    
    struct DataHistoryDto: Codable {
        var data: [Record]
    }
}
