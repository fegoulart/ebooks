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
        //return Session().request(.getBooks(term: "swift"))
        return Promise { seal in
            
            AF.request(APIRouter.getBooks(term: "swift"))
                .validate()
                .responseDecodable(of: EBooks.self) {
                    response in
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
        //let client = Session()
        
        let expectation = self.expectation(description: "Get EBooks")
        let teste = loadObjects()
        
        
        teste.done { ebooks in
            print(">>>>>>>>>>>>>>>>>>>>\(ebooks.resultCount ?? -1)")
            print(">>>>>>>>>>>>>>>>>>>>\(ebooks.results?.count ?? -1)")
            expectation.fulfill()
        }
        .catch { error in
            print(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
}
