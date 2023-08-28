//
//  IllustrateTableViewCell.swift
//  EViOS3
//
//  Created by Student07 on 28/08/2023.
//

import UIKit
import AlamofireImage

class IllustrateTableViewCell: UITableViewCell {
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(illu: IllustrateCoins.IllustrateCoin){
        txtName.text = illu.name
        imgCoin.af.setImage(
            withURL: URL(string: illu.icon)!,
            placeholderImage: UIImage(systemName: "photo"),
            imageTransition: .crossDissolve(0.7)
        )
    }
    
}
