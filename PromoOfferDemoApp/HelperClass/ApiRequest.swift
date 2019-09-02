//
//  ApiRequest.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit

class ApiRequest: NSObject
{
    func fetchPromoList(using apiUrl: String, handler: @escaping(_ response: Data?, _ error: Error?) -> ()) {
        guard let promoListbaseUrl = URL(string: apiUrl) else {
            return
        }
        let task = URLSession.shared.dataTask(with: promoListbaseUrl) { (data, reposne, error) in
            if let error = error {
                handler(nil, error)
                return
            }
            if let data = data {
                handler(data, nil)
            }
        }
        task.resume()
    }
}
