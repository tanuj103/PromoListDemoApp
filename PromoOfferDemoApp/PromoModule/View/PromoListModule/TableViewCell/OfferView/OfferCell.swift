//
//  OfferCell.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
private let OfferCollectionViewCellIdentifier = "offerCollectionViewCell";

protocol OfferCellDelegate : class {
    func seeAllButtonClicked(verticalList : VerticalList)
    func openOfferDetailView(offerModel : Offer)
}

class OfferCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var verticalNameLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    private var verticalList : VerticalList!
    weak var offerCellDelegate:OfferCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seeAllButton.layer.borderWidth = 1
        seeAllButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 111.0/255.0, blue: 212.0/255.0, alpha: 1.0).cgColor
        self.collectionView.register(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OfferCollectionViewCellIdentifier)
    }
    
    func configTableViewCellUI(verticalListModel: AnyObject) {
        verticalList = verticalListModel as? VerticalList
        verticalNameLabel.text = verticalList.verticalName
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return verticalList.offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferCollectionViewCellIdentifier, for: indexPath) as? OfferCollectionViewCell {
            cell.configCollectionViewCellUI(offerList: verticalList.offers[indexPath.row] as AnyObject)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       self.offerCellDelegate?.openOfferDetailView(offerModel: verticalList.offers[indexPath.row])
    }
    
    @IBAction func seeAllButtonClicked(_ sender: UIButton)
    {
        self.offerCellDelegate?.seeAllButtonClicked(verticalList: verticalList)
    }
    
}
