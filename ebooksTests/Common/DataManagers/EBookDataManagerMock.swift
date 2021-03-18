//
//  EBookDataManagersMock.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import PromiseKit
@testable import ebooks

final class EBookDataManagerMock: EBookDataManager {
    var getEBooksCalled = false

    func getEBooks(from term: String) -> Promise<EBooks> {
        return APIManager.callApi(
            APIRouter(
                route: Route.getBooks(term: term)),
            dataReturnType: EBooks.self,
            test: true)
    }
}

final class EBookDataManagerMockError: EBookDataManager {
    func getEBooks(from term: String) -> Promise<EBooks> {
        return Promise(error: ListingError.couldNotFetchEBooks(error: "fakeError" ))
    }
}
