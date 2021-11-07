//
//  Coin.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: Int
    let name: String
    let symbol: String
    let price: Float
}

struct DataContainer<T: Decodable>: Decodable {
    let data: T
}

extension Coin {
    static let all = [
        "BTC",
        "ETH",
        "BNB",
        "SOL",
        "ADA",
        "XRP",
        "DOGE",
        "SHIB",
        "LUNA",
        "AVAX",
        "UNI",
        "LINK",
    ]
}
