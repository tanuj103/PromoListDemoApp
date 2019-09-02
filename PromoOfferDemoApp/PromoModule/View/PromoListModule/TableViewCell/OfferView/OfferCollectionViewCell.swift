//
//  OfferCollectionViewCell.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 01/09/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var offerTypeLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCollectionViewCellUI(offerList: AnyObject) {
        let offerModel = offerList as? Offer
        logoImageView.sd_setImage(with: URL(string: offerModel!.logoUrl!), placeholderImage: UIImage(named: ""))
        offerTypeLabel.text = offerModel?.offerType
        productTitleLabel.text = offerModel?.productTitle
    }
}
