//
//  APIManger.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 17/03/21.
//

import PromiseKit
import OHHTTPStubs
import Alamofire

protocol GeneralAPI {
    static func callApi<T: Decodable>(_ target: APIRouter,
                                      dataReturnType: T.Type) -> Promise<T>
}

class APIManager: GeneralAPI {
    static func callApi<ReturnedObject: Decodable>(_ target: APIRouter,
                                                   dataReturnType: ReturnedObject.Type)
    -> Promise<ReturnedObject> {
        return Promise<ReturnedObject> { seal in
            AF.request(target)
                .validate()
                .responseDecodable(of: ReturnedObject.self) { response in
                    switch response.result {
                    case.success(let objects):
                        seal.fulfill(objects)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }}
    }
}
