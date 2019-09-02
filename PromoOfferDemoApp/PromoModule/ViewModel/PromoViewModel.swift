//
//  PromoViewModel.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class PromoViewModel: NSObject {
    var onDataFetch: ((_ promoModel: PromoModel) -> Void)?
    
    func apiCallForPromoList()
    {
        //Initiate PromoList Api Call
        ApiRequest().fetchPromoList(using: Constants.PROMO_LIST_API) {(data, error) in
            guard let data = data else {
                return
            }
            do {
                let promoModel = try JSONDecoder().decode(PromoModel.self, from: data)
                self.onDataFetch?(promoModel)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
