//
//  AllOfferListVC.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 01/09/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
private let OfferCollectionViewCellIdentifier = "offerCollectionViewCell";

class AllOfferListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var verticalList : VerticalList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Offer List"
        self.collectionView.register(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OfferCollectionViewCellIdentifier)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 10
        let collectionCellSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let offerDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "offerDetailVC") as! OfferDetailVC
        offerDetailController.offerModel = verticalList.offers[indexPath.row]
        self.navigationController?.pushViewController(offerDetailController, animated: true)
    }
}
