//
//  SearchInteractorTests.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 19/03/21.
//

@testable import ebooks
import XCTest
import PromiseKit
import OHHTTPStubs

class SearchInteractorTests : XCTestCase {

    private var searchInteractor: SearchInteractor?
    private var mockWorker : SearchWorker?
    private var errorDataManager: EBookDataManager?
    private var mockTrendingWorker : SearchTrendingWorker?
    private var presenterMock : SearchPresenterMock?

    override func setUp() {
        searchInteractor = SearchInteractor()
        mockWorker = SearchWorker(dataManager: EBookNetworkManagerMock())
        mockTrendingWorker = SearchTrendingWorker(dataManager: TrendingLocalStorageManagerMock())
        searchInteractor?.worker = mockWorker
        errorDataManager = EBookDataManagerMockError()
        UserDefaults.standard.removeObject(forKey: "TrendingsMock")
        presenterMock  = SearchPresenterMock()
        searchInteractor?.presenter = presenterMock
        stub(condition: isHost(APIConfig.baseDomain) ) { _ in
            guard let path =
                    OHPathForFile("EBooks_stub_response.json",
                        type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return fixture(
                filePath: path,
                status: 200,
                headers: ["Content-Type":"text/javascript; charset=utf-8"])
        }
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "TrendingsMock")
    }

    func testWorkerFetchEbooks() {
        var response: SearchPage.FetchEBooks.Response!
        let expectation = self.expectation(description: "Get EBooks Test")
        mockWorker?.dataManager.getEBooks(from: "switch").done { eBooks in
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

    func testWorkerFetchEbooksError() {
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

    func testWorkerSaveTrending() {
        let expectation = self.expectation(description: "Saving term as Trending")
        mockTrendingWorker?.dataManager.saveTrending(term: "chocolate").done { currentResponse in
            XCTAssert(currentResponse)
            self.mockTrendingWorker?.dataManager.getTrendings().done { trendings in
                if trendings.contains("chocolate") {
                    XCTAssert(true)
                    expectation.fulfill()
                } else {
                    XCTAssert(false)
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
