//
//  Alamofire+Extensions.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

import Alamofire
import PromiseKit

extension Alamofire.DataRequest {
    // Return a Promise for a Codable
    public func responseDecodable<T: Decodable>(queue: DispatchQueue = DispatchQueue.main) -> Promise<T> {
        return Promise { seal in
            responseData(queue: queue) { response in
                switch response.result {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do {
                        seal.fulfill(try decoder.decode(T.self, from: value))
                    } catch let error {
                        seal.reject(error)
                    }
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 400:
                        seal.reject(CleanNetworkError.badAPIRequest)
                    case 401:
                        seal.reject(CleanNetworkError.unauthorized)
                    default:
                        guard NetworkReachabilityManager()?.isReachable ?? false else {
                            seal.reject(CleanNetworkError.noInternet)
                            return
                        }
                        print(error)
                        seal.reject(CleanNetworkError.unknown)
                    }
                }
            }
        }
    }
}
