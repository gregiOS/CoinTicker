//
//  CoinCell.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI

struct CoinCell: View {
    let coin: Coin
    
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
            Text("\(coin.price) $")
            Image(systemName: "arrow.up.circle")
                .foregroundColor(.green)
        }
    }
    
    private func localImage() -> Image? {
#if DEBUG
        return ImagePreviews.mocks[coin.symbol]
#else
        return nil
#endif
    }
}
