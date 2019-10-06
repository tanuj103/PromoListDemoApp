//
//  PromoListVC.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
private let PromoSectionIdentifier      = "promoSection";
private let OfferSectionIdentifier      = "offerSection";
private let PromotionCellIdentifier     = "promotionCell";
private let OfferCellIdentifier         = "offerCell";
private let AllOfferListVCIdentifier    = "allOfferListVC";
private let OfferDetailViewIdentifier   = "offerDetailVC";

class PromoListVC: UIViewController, OfferCellDelegate {
    
    @IBOutlet weak var promoListTableView: UITableView!
    private var promoViewModel =  PromoViewModel()
    private var promoDataModel : PromoModel!
    private var sectionArray : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        promoListApiCall()
    }
    
    func configUI()
    {
        self.title = "Offers List"
        self.promoListTableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: OfferCellIdentifier)
    }
    
    func promoListApiCall()
    {
        promoViewModel.onDataFetch = { [weak self] (promoModel: PromoModel) in
            self?.reloadTableViewWithData(promoModel: promoModel)
        }
        promoViewModel.apiCallForPromoList()
    }
    
    func reloadTableViewWithData(promoModel: PromoModel)
    {
        promoDataModel = promoModel
        if(!promoModel.data.promotedOffers.offers.isEmpty)
        {
            sectionArray.add(PromoSectionIdentifier)
        }
        if(!promoModel.data.verticalList.isEmpty)
        {
            sectionArray.add(OfferSectionIdentifier)
        }
        DispatchQueue.main.async {
            self.promoListTableView.reloadData()
        }
    }
    
}

//MARK: Tableview Delegate Method
extension PromoListVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionIdentifier = sectionArray[section] as! String
        if (sectionIdentifier == PromoSectionIdentifier){
            return 1
        }
        else if (sectionIdentifier == OfferSectionIdentifier){
            return promoDataModel.data.verticalList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIdentifier = sectionArray[indexPath.section] as! String
        if (sectionIdentifier == PromoSectionIdentifier){
            let cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: PromotionCellIdentifier)
            //ADD PAGEVIEWCONTROLLER CHILD TO PARENT
            if cell?.contentView.tag != 100{
                let pageViewController = PromoPageController (offerModel: promoDataModel.data.promotedOffers.offers as AnyObject)
                addChild(pageViewController)
                pageViewController.view.frame = (cell!.contentView.bounds)
                pageViewController.didMove(toParent: self)
                cell?.contentView.tag = 100
                cell!.contentView.addSubview(pageViewController.view)
            }
            return cell!
        }
        else {
            let offerCell = tableView.dequeueReusableCell(withIdentifier: OfferCellIdentifier, for: indexPath) as! OfferCell
            offerCell.offerCellDelegate = self
            offerCell.configTableViewCellUI(verticalListModel: promoDataModel.data.verticalList[indexPath.row] as AnyObject)
            return offerCell
        }
    }
    
    func openOfferDetailView(offerModel: Offer){
        let offerDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: OfferDetailViewIdentifier) as! OfferDetailVC
        offerDetailController.offerModel = offerModel
        self.navigationController?.pushViewController(offerDetailController, animated: true)
    }
    
    func seeAllButtonClicked(verticalList: VerticalList) {
        let allOfferListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AllOfferListVCIdentifier) as! AllOfferListVC
        allOfferListController.verticalList = verticalList
        self.navigationController?.pushViewController(allOfferListController, animated: true)
    }
}

