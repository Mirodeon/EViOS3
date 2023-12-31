//
//  RecordTableViewCell.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        addLineargradient(
            left: UIColor.black.cgColor,
            center: UIColor.white.cgColor,
            right: UIColor.black.cgColor,
            view: contentView
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(record: History.Record){
        txtPrice.text = formattedPrice(price: record.priceUsd)
        txtTime.text = formattedDate(date: record.date)
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
    
    func formattedDate(date: String) -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let dateDate = dateFormatterInput.date(from: date)
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateStyle = .short
        return dateFormatterOutput.string(from: dateDate ?? Date())
    }
    
    func addLineargradient(left: CGColor, center: CGColor, right: CGColor, view: UIView) {
        let gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.colors = [left, center, right]
            gradient.locations = [0.0, 0.5, 1.0]
            gradient.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
            return gradient
        }()
        
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}
