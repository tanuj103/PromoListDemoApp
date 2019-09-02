//
//  PromoView.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class PromoView: UIViewController {
    var index = 0
    @IBOutlet weak var promoImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    var imageUrl:NSString = ""
    var productTile:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoImageView.image = nil
        promoImageView.sd_setImage(with: URL(string: imageUrl as String), placeholderImage: UIImage(named: ""))
        productTitleLabel.text = ""
        productTitleLabel.text = productTile as String
    }
    
    func setValues(index: Int, topOfferModel : AnyObject?) {
        self.index = index
        let model = topOfferModel as! Offer
        imageUrl = model.imageUrl! as NSString
        productTile = model.productTitle! as NSString
    }
    
}
