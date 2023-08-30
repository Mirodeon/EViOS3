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
        
        containerHistory.layer.cornerRadius = 12
        containerHistory.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        selectionStyle = .none
        addLineargradient(
            top: UIColor.black.cgColor,
            bottom: UIColor.white.cgColor,
            view: contentView
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
    
    func addLineargradient(top: CGColor, bottom: CGColor, view: UIView) {
        let gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.colors = [top, bottom]
            gradient.locations = [ 0.0, 0.9]
            return gradient
        }()
        
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}
