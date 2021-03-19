//
//  TrendingDataManagerMock.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 19/03/21.
//

import PromiseKit
@testable import ebooks

protocol TrendingLocalStorageInjectedMock {
}

struct TrendingLocalStorageInjectorMock {
    static var localStorageManager: TrendingDataManager = TrendingLocalStorageManagerMock()
}

extension TrendingLocalStorageInjectedMock {
    var trendingDataManager: TrendingDataManager {
        return TrendingLocalStorageInjectorMock.localStorageManager
    }
}

final class TrendingLocalStorageManagerMock: TrendingDataManager {

    func getTrendings() -> Promise<[String]> {
        return Promise<[String]> { seal in
            let defaults = UserDefaults.standard
            let trendings = defaults.stringArray(forKey: "TrendingsMock") ?? [String]()
            seal.fulfill(trendings)
        }
    }
    func saveTrending(term: String) -> Promise<Bool> {
        return Promise<Bool> { seal in
            let defaults = UserDefaults.standard
            var currentTrendings = defaults.stringArray(forKey: "TrendingsMock") ?? [String]()
            if !currentTrendings.contains(term) {
                currentTrendings.insert(term, at: 0)
            }
            defaults.set(currentTrendings, forKey: "TrendingsMock")
            seal.fulfill(true)
        }
    }
}
