//
//  MockAPI.swift
//  CoinTickerTests
//
//  Created by Grzegorz Przybyła on 21/11/2021.
//

import Foundation
import Combine
@testable import CoinTicker

final class MockAPI: API {
    enum Result {
        case loading
        case fail
        case mocked([String: Data])
    }
    
    var result: Result = .loading
    
    func load<T>(coinSymbol: String, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        switch result {
        case .loading:
            return Future<T, Error> { _ in }
            .eraseToAnyPublisher()
        case .fail:
            return Fail<T, Error>(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        case .mocked(let mocks):
            return loadMocked(coinSymbol: coinSymbol, type: type, mockData: mocks)
        }
    }
    
    private func loadMocked<T>(coinSymbol: String, type: T.Type, mockData: [String: Data]) -> AnyPublisher<T, Error> where T : Decodable {
        guard let data = mockData[coinSymbol] else {
            fatalError()
        }
        do {
            let response = try decoder().decode(type, from: data)
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            fatalError("Cannot decode data: \(error)")
        }
    }
    
    private func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension Bundle {
    static let test = Bundle(for: CoinListSnapshotTests.classForCoder())
}

extension Data {
    static let ada = Data.jsonFromBundle(of: "ada")
    static let eth = Data.jsonFromBundle(of: "eth")
    static let btc = Data.jsonFromBundle(of: "btc")
    static let doge = Data.jsonFromBundle(of: "doge")
    static let xrp = Data.jsonFromBundle(of: "xrp")
    
    // MARK: - Private
    
    private static func jsonFromBundle(of name: String) -> Data {
        guard let path = Bundle.test.path(forResource: name, ofType: "json") else {
            fatalError("File \(name) doesnt exists")
        }
        
        guard let json = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("File \(name) is not valid json file")
        }
        
        return json.data(using: .utf8)!
    }
}
