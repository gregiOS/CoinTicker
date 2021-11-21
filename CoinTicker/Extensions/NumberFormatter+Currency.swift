//
//  NumberFormatter+Currency.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 21/11/2021.
//

import Foundation

extension NumberFormatter {
    static let usdCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
}
