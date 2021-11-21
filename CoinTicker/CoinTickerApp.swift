//
//  CoinTickerApp.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI

@main
struct CoinTickerApp: App {
    var body: some Scene {
        WindowGroup {
            CoinListView(
                viewModel: .init(
                    symbols: Coin.all                            )
            )
        }
    }
}
