//
//  XCTestCase+AssertSnapshot.swift
//  CoinTickerTests
//
//  Created by Grzegorz Przybyła on 21/11/2021.
//

import XCTest
import SwiftUI
import SnapshotTesting

extension XCTestCase {
    
    func assertSnapshot<V: View>(
        view: V,
        file: StaticString = #file,
        line: UInt = #line,
        testName: String = #function
    ) {
        assertSnapshot(
            view: view,
            transform: { $0 }
        )
    }
    
    
    func assertSnapshot<V: View, Y: View>(
        view: V,
        transform: (V) -> Y,
        file: StaticString = #file,
        line: UInt = #line,
        testName: String = #function
    ) {
        [UIUserInterfaceStyle.light, .dark].forEach { userInterfaceStyle in
            assertSnapshots(
                matching: transform(view),
                as: [
                    .wait(
                        for: 0.0, on: .image(
                            drawHierarchyInKeyWindow: true,
                            layout: .fixed(width: 390, height: 844),
                            traits: .init(userInterfaceStyle: userInterfaceStyle)
                        )
                    )
                ],
                file: file,
                testName: [String(describing: self), testName, userInterfaceStyle.description].joined(separator: "_"),
                line: line
            )
        }
    }
}


extension UIUserInterfaceStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .light:
            return "light"
        case .dark:
            return "dark"
        @unknown default:
            return "@unknown"
        }
    }
}
