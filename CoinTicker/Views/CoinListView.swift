//
//  CoinListView.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import SwiftUI
import Combine

enum Loadable<T: Equatable>: Equatable {
    case idle
    case loading
    case loaded(T)
    case failed(String)
}

final class CoinListViewModel: ObservableObject {
    @Published var coins: Loadable<[Coin]> = .idle
    
    private let api: API
    private let symbols: [String]
    private var cancellables = Set<AnyCancellable>()
    
    init(symbols: [String], api: API = APILive()) {
        self.symbols = symbols
        self.api = api
        load()
    }
    
    private func load() {
        coins = .loading
        Publishers.MergeMany(symbols
                                .map { api.load(coinSymbol: $0, type: DataContainer<[Coin]>.self)})
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure:
                    self?.coins = .failed("Cannot load coin data")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] values in
                let coins = values
                    .flatMap { $0.data }
                    .sorted(by: { $0.name <= $1.name })
                self?.coins = .loaded(coins)
            })
            .store(in: &cancellables)
    }
}
struct CoinListView: View {
    @ObservedObject
    var viewModel: CoinListViewModel
    
    var body: some View {
        content()
        .navigationTitle("Coin Ticker")
    }
    
    @ViewBuilder
    private func content() -> some View {
        switch viewModel.coins {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .loaded(let coins):
            List {
                Section(content: {
                    ForEach(coins) { coin in
                        CoinCell(coin: coin)
                    }
                }, header: HeaderView.init)
            }
        case .failed:
            Text("Cannot load coin data")
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView(
            viewModel: .init(
                symbols: Coin.all
            )
        )
    }
}
