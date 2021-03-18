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
                                      dataReturnType: T.Type,
                                      test: Bool) -> Promise<T>
}

class APIManager: GeneralAPI {
    static func callApi<ReturnedObject: Decodable>(_ target: APIRouter,
                                                   dataReturnType: ReturnedObject.Type,
                                                   test: Bool = false) -> Promise<ReturnedObject> {
        if test {
            stub(condition: isHost(APIConfig.baseDomain) ) { _ in
                guard let path =
                        OHPathForFile(
                            "\(String(describing: dataReturnType).self)_stub_response.json",
                             self as AnyClass) else {
                    preconditionFailure("Could not find expected file in test bundle")
                }
                return fixture(filePath: path, status: 200, headers: ["Content-Type":"application/json"])
            }
        }
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
