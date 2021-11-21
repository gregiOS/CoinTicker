//
//  CoinCell.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI

struct CoinCell: View {
    let coin: Coin
    let priceFormatter = NumberFormatter.usdCurrency
    
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URLImage.coinLogo[coin.symbol]?.flatMap { $0 },
                transform: { $0.resizable() },
                localImage: localImage
            )
                .frame(width: 24, height: 24)
            Text(coin.name)
            Spacer()
            Text(price)
            Image(systemName: "arrow.up.circle")
                .foregroundColor(.green)
        }
    }
    
    private var price: String {
        priceFormatter.string(from: NSNumber(value: coin.price)) ?? ""
    }
    
    private func localImage() -> Image? {
#if DEBUG
        return ImagePreviews.mocks[coin.symbol]
#else
        return nil
#endif
    }
}
