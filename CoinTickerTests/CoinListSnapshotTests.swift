//
//  CoinListSnapshotTests.swift
//  CoinTickerTests
//
//  Created by Grzegorz Przybyła on 20/11/2021.
//

import XCTest
import SnapshotTesting
import Combine
import SwiftUI
@testable import CoinTicker

class CoinListSnapshotTests: XCTestCase {
    private let apiMock = MockAPI()
    
    override func setUp() {
        super.setUp()
        ImagePreviews.mocks = ImagePreviews.withDataMocks
    }
    
    override func tearDown() {
        super.tearDown()
        ImagePreviews.mocks = [:]
    }
    
    func testLoading() {
        let content = CoinListView(viewModel: .init(symbols: Coin.tests, api: apiMock))
           
        assertSnapshot(
            view: content,
            transform: { view in
                NavigationView(content: { view })
            }
        )
    }
    
    
    func testLoaded() {
        apiMock.result = .mocked(
            [
                "ADA": Data.ada,
                "ETH": Data.eth,
                "BTC": Data.btc,
                "DOGE": Data.doge,
                "XRP": Data.xrp,
            ]
        )
        
        let content = CoinListView(viewModel: .init(symbols: Coin.tests, api: apiMock))
           
        assertSnapshot(
            view: content,
            transform: { view in
                NavigationView(content: { view })
            }
        )
    }
    
    func testFailed() {
        apiMock.result = .fail
        
        let content = CoinListView(viewModel: .init(symbols: Coin.tests, api: apiMock))
           
        assertSnapshot(
            view: content,
            transform: { view in
                NavigationView(content: { view })
            }
        )
    }
}

