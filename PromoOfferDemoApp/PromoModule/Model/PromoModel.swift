//
//  PromoModel.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import Foundation

struct PromoModel: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: DataClass
struct DataClass: Codable {
    let verticalList: [VerticalList]
    let promotedOffers: PromotedOffers
}

// MARK: VerticalList
struct VerticalList: Codable {
    let id, verticalName: String
    let offers: [Offer]
}

// MARK: PromotedOffers
struct PromotedOffers: Codable {
    let id: String
    let offers: [Offer]
}

// MARK: Offer
struct Offer: Codable {
    let offerId: String?
    let imageUrl: String?
    let productTitle: String?
    let merchantName: String?
    let logoUrl: String?
    let offerType: String?
    let details : Details
}

// MARK: Details
struct Details: Codable {
    let specifics: String?
}
