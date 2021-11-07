//
//  Image+Mocks.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI

#if DEBUG
struct ImagePreviews {
    
    static var mocks: [String: Image] = [:]
    
    static var withDataMocks = [
        "BTC": Image("bitcoin"),
        "ETH": Image("eth"),
        "BNB": Image("bnb"),
        "SOL": Image("sol"),
        "ADA": Image("ada"),
        "XRP": Image("xrp"),
        "DOGE": Image("doge"),
        "SHIB": Image("inu-shib"),
        "LUNA": Image("luna"),
        "AVAX": Image("avax"),
        "UNI": Image("uni"),
        "LINK": Image("link")
    ]
}
#endif
