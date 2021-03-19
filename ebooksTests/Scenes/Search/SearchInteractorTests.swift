//
//  SearchInteractorTests.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 19/03/21.
//

@testable import ebooks
import XCTest
import PromiseKit

class SearchInteractorTests : XCTestCase {

    private var searchInteractor: SearchInteractor?
    private var dataManager : EBookDataManager?
    private var errorDataManager: EBookDataManager?

    override func setUp() {
        searchInteractor = SearchInteractor()
        dataManager = EBookDataManagerMock()
        errorDataManager = EBookDataManagerMockError()
    }

    func testFetchEbooks() {
        var response: SearchPage.FetchEBooks.Response!
        let expectation = self.expectation(description: "Get EBooks Test")
        self.dataManager?.getEBooks(from: "switch").done { eBooks in
            var newEBooks: [EBook] = []
            for eBook in eBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            response = SearchPage.FetchEBooks.Response(eBooks: newEBooks, error: nil)
        }.catch { _ in
            response = SearchPage.FetchEBooks.Response(
                eBooks: nil,
                error: SearchError.couldNotFetchEBooks(error: "test error"))
            XCTAssert(false)
        }.finally {
            XCTAssertEqual(response.eBooks?.count, 50)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testFetchEbooksError() {
        var response: SearchPage.FetchEBooks.Response!
        let expectation = self.expectation(description: "Get EBooks Test")
        self.errorDataManager?.getEBooks(from: "switch").done { eBooks in
            var newEBooks: [EBook] = []
            for eBook in eBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            response = SearchPage.FetchEBooks.Response(eBooks: newEBooks, error: nil)
        }.catch { _ in
            response = SearchPage.FetchEBooks.Response(
                eBooks: nil,
                error: SearchError.couldNotFetchEBooks(error: "test error"))
            XCTAssert(true)
        }.finally {
            XCTAssertNil(response.eBooks)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
