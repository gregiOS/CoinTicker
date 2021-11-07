//
//  ContentView.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI
import Combine

final class CoinListViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    
    private let api: API
    private let symbols: [String]
    private var cancellables = Set<AnyCancellable>()
    
    init(symbols: [String], api: API = APILive()) {
        self.symbols = symbols
        self.api = api
    }
    
    func load() {
        Publishers.MergeMany(Coin.all
                                .map { api.load(coinSymbol: $0, type: DataContainer<[Coin]>.self)})
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                debugPrint(error)
            }, receiveValue: { values in
                let coins = values
                    .flatMap { $0.data }
                    .sorted(by: { $0.name <= $1.name })
                self.coins = coins
            })
            .store(in: &cancellables)
    }
}
struct ContentView: View {
    @ObservedObject
    var viewModel: CoinListViewModel
    
    var body: some View {
        List {
            Section(content: {
                ForEach(viewModel.coins) { coin in
                    CoinCell(coin: coin)
                }
            }, header: HeaderView.init)
        }
        .onAppear(perform: viewModel.load)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: .init(
                symbols: Coin.all
            )
        )
    }
}
