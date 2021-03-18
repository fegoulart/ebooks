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

    override func setUp() {
        listingInteractor = ListingInteractor()
        dataManager = EBookDataManagerMock()
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
            expectation.fulfill()
        }.finally {
            XCTAssertEqual(response.eBooks?.count, 50)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
}

/*
 var presenter: ListingPresentationLogic?
 var worker = ListingWorker()
 var eBooks: EBooks?

 func fetchTerm(request: ListingPage.FetchEBooks.Request) {
     var response: ListingPage.FetchEBooks.Response!
     self.worker.eBookDataManager.getEBooks(from: request.term).done { eBooks in
         var newEBooks: [EBook] = []
         for eBook in eBooks.results ?? [] {
             newEBooks.append(eBook)
         }
         response = ListingPage.FetchEBooks.Response(eBooks: newEBooks, error: nil)
     }.catch { error in
         response = ListingPage.FetchEBooks.Response(
             eBooks: nil,
             error: ListingError.couldNotFetchEBooks(error: error.localizedDescription))
     }.finally {
         self.presenter?.presentListing(response: response)
     }
 }
 */
