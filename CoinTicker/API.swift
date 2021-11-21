//
//  API.swift
//  CoinTicker
//
//  Created by Grzegorz Przybyła on 07/11/2021.
//

import Foundation
import Combine

protocol API {
    func load<T: Decodable>(coinSymbol: String, type: T.Type) -> AnyPublisher<T, Error>
}

struct APILive: API {
    let host = "api.lunarcrush.com"
    let apiKey = "a76rvnw3hutiafokvpbol2vikcesxn"
    
    let session = URLSession.shared
    
    func load<T: Decodable>(coinSymbol: String, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = createURL(symbol: coinSymbol) else {
            fatalError("Could not create url")
        }
        
        return session
            .dataTaskPublisher(for: url)
            .map { response in
                return response.data
            }
            .decode(type: T.self, decoder: decoder())
            .eraseToAnyPublisher()
    }
    
    private func createURL(symbol: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/v2"
        components.queryItems = [
            URLQueryItem(name: "data", value: "assets"),
            .init(name: "key", value: apiKey),
            .init(name: "symbol", value: symbol)
        ]
        
        return components.url
    }
    
    private func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
