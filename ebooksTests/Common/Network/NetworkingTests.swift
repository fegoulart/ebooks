//
//  NetworkingTests.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 17/03/21.
//

import XCTest
@testable import ebooks
import OHHTTPStubs
import Alamofire
import PromiseKit

class NetworkingTests: XCTestCase {

    func loadObjects() -> Promise<EBooks> {

        return Promise { seal in
            AF.request(APIRouter(route: Route.getBooks(term: "swift")))
                .validate()
                .responseDecodable(of: EBooks.self) { response in
                    switch response.result {
                    case .success(let eBooks):
                        seal.fulfill(eBooks)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
        }
    }

    func testGetEBooksSuccess() {
        let testHost = APIConfig.baseDomain
        stub(condition: isHost(testHost) ) { _ in
            guard let path = OHPathForFile("resource_success_response.json", type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return fixture(filePath: path, status: 200, headers: ["Content-Type":"application/json"])

        }

        let expectation = self.expectation(description: "Get EBooks")
        let requestTest = loadObjects()

        requestTest.done { ebooks in
            XCTAssertEqual(ebooks.resultCount, 50)
            XCTAssertEqual(ebooks.results?.count, 50)
            expectation.fulfill()
        }
        .catch { _ in
            XCTAssert(false)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
