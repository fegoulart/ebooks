//
//  TrendingDataMager.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import PromiseKit

protocol TrendingDataManager: AnyObject {
    func getTrendings() -> Promise<[String]>
    func saveTrending(term: String) -> Promise<Bool>
}

final class TrendingLocalStorageManager: TrendingDataManager {
    func getTrendings() -> Promise<[String]> {
        return Promise<[String]> { seal in
            let defaults = UserDefaults.standard
            let trendings = defaults.stringArray(forKey: "Trendings") ?? [String]()
            seal.fulfill(trendings)
        }
    }
    func saveTrending(term: String) -> Promise<Bool> {
        return Promise<Bool> { seal in
            let defaults = UserDefaults.standard
            var currentTrendings = defaults.stringArray(forKey: "Trendings") ?? [String]()
            if !currentTrendings.contains(term) {
                currentTrendings.insert(term, at: 0)
            }
            defaults.set(currentTrendings, forKey: "Trendings")
            seal.fulfill(true)
        }
    }
}
