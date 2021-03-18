//
//  ListingInteractorTests.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

@testable import ebooks
import XCTest
import PromiseKit

class ListingInteractorTests : XCTestCase {

    private var listingInteractor: ListingInteractor?
    private var dataManager : EBookDataManager?
    private var errorDataManager: EBookDataManager?

    override func setUp() {
        listingInteractor = ListingInteractor()
        dataManager = EBookDataManagerMock()
        errorDataManager = EBookDataManagerMockError()
    }

    func testFetchEbooks() {
        var response: ListingPage.FetchEBooks.Response!
        let expectation = self.expectation(description: "Get EBooks Test")
        self.dataManager?.getEBooks(from: "switch").done { eBooks in
            var newEBooks: [EBook] = []
            for eBook in eBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            response = ListingPage.FetchEBooks.Response(eBooks: newEBooks, error: nil)
        }.catch { _ in
            response = ListingPage.FetchEBooks.Response(
                eBooks: nil,
                error: ListingError.couldNotFetchEBooks(error: "test error"))
            XCTAssert(false)
        }.finally {
            XCTAssertEqual(response.eBooks?.count, 50)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }

    func testFetchEbooksError() {
        var response: ListingPage.FetchEBooks.Response!
        let expectation = self.expectation(description: "Get EBooks Test")
        self.errorDataManager?.getEBooks(from: "switch").done { eBooks in
            var newEBooks: [EBook] = []
            for eBook in eBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            response = ListingPage.FetchEBooks.Response(eBooks: newEBooks, error: nil)
        }.catch { _ in
            response = ListingPage.FetchEBooks.Response(
                eBooks: nil,
                error: ListingError.couldNotFetchEBooks(error: "test error"))
            XCTAssert(true)
        }.finally {
            XCTAssertNil(response.eBooks)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}
