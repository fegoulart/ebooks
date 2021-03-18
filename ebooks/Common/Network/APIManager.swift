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
                                      test: Bool,
                                      debugMode: Bool) -> Promise<T>
}

struct APIManager: GeneralAPI {
    static func callApi<ReturnedObject: Decodable>(_ target: APIRouter,
                                                   dataReturnType: ReturnedObject.Type,
                                                   test: Bool = false,
                                                   debugMode: Bool = false) -> Promise<ReturnedObject> {
        if test {
            stub(condition: isHost(APIConfig.baseDomain) ) { _ in
                // swiftlint:disable force_cast
                guard let path =
                        OHPathForFile(
    "Stubs/\(ReturnedObject.self)resource_success_response.json",
                            ReturnedObject.self as! AnyClass) else {
                    preconditionFailure("Could not find expected file in test bundle")
                }
                // swiftlint:enable force_cast
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
