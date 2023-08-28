//
//  CoinTableViewCell.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtRank: UILabel!
    @IBOutlet weak var btnExplorer: UIButton!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtPercent: UILabel!
    
    var onClick: CoinCellClick?
    var coin: Coins.Coin?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        txtRank.layer.cornerRadius = 16
        txtRank.layer.maskedCorners = [.layerMaxXMaxYCorner]
        txtRank.layer.masksToBounds = true
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(coin: Coins.Coin, onClick: CoinCellClick) {
        self.coin = coin
        self.onClick = onClick
        txtRank.text = coin.rank
        txtName.text = coin.name
        txtPrice.text = formattedPrice(price: coin.priceUsd)
        txtPercent.text = formattedPercent(percent: coin.changePercent24Hr)
        txtPercent.textColor = coin.changePercent24Hr.contains("-") ? .red : .green
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
    
    func formattedPercent(percent: String) -> String {
        guard let doublePercent = Double(percent) else {
            return "- %"
        }
        let roundedPercent = Double(round(doublePercent * 100) / 100)
        return "\(roundedPercent > 0 ? "+" : "")\(roundedPercent)%"
    }
    
    @IBAction func explorerAction(_ sender: UIButton) {
        if let explorer = coin?.explorer{
            onClick?.exploreCoin(explorer: explorer)
            
        }
    }
}

protocol CoinCellClick {
    func exploreCoin(explorer: String)
}
