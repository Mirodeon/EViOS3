//
//  LeadHistoryTableViewCell.swift
//  EViOS3
//
//  Created by Student07 on 29/08/2023.
//

import UIKit

class LeadHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var containerHistory: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        containerHistory.layer.cornerRadius = 12
        containerHistory.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        selectionStyle = .none
    }
    
    func setup(record: History.Record, coin: Coins.Coin){
        txtPrice.text = formattedPrice(price: record.priceUsd)
        txtName.text = coin.name
    }
    
    func formattedPrice(price: String) -> String? {
        if let double = Double(price) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "USD"
            return formatter.string(from: double as NSNumber)
        }
        return "- $"
    }
}
