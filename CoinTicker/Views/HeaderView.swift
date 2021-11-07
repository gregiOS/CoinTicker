//
//  HeaderView.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Coin")
            Spacer()
            Text("Price")
            Text("Change")
        }
    }
}
