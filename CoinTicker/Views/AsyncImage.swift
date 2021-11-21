//
//  AsyncImage.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI

#if DEBUG

var testImages: [URL?: Image] = [:]

#endif

struct AsyncImage<T: View>: View {
    let url: URL?
    let transform: (Image) -> T
    let localImage: () -> Image?
    
    var body: some View {
        if let image = localImage() {
            transform(image)
        } else {
            SwiftUI.AsyncImage(
                url: url,
                content: transform,
                placeholder: ProgressView.init
            )
        }
    }
}
