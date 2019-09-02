//
//  OfferDetailVC.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 01/09/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class OfferDetailVC: UIViewController {
    @IBOutlet weak var offerdetailImageView: UIImageView!
    @IBOutlet weak var offerdetailTextView: UITextView!
    var offerModel : Offer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Offer Detail"
        
        offerdetailImageView.sd_setImage(with: URL(string: offerModel.imageUrl!), placeholderImage: UIImage(named: ""))
        
        let specificsString = "\n\nOffer Details\n\n"
        var appendString = offerModel.productTitle! + specificsString
        appendString.append(offerModel.details.specifics!)
        let detailString = appendString.replacingOccurrences(of: "|", with: "\n\n", options: .literal, range: nil)
        offerdetailTextView.text = detailString
    }
    
}
