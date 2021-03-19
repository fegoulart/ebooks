//
//  EBookDataManagersMock.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import PromiseKit
@testable import ebooks

protocol EBookNetworkInjectedMock {
}

struct EBookNetworkInjectorMock {
    static var networkManager: EBookDataManager = EBookNetworkManagerMock()
}

extension EBookNetworkInjectedMock {
    var eBookDataManager: EBookDataManager {
        return EBookNetworkInjectorMock.networkManager
    }
}

final class EBookNetworkManagerMock: EBookDataManager {
    func getEBooks(from term: String) -> Promise<EBooks> {
        return APIManager.callApi(
            APIRouter(
                route: Route.getBooks(term: term)),
            dataReturnType: EBooks.self)
    }
}

final class EBookDataManagerMockError: EBookDataManager {
    func getEBooks(from term: String) -> Promise<EBooks> {
        return Promise(error: ListingError.couldNotFetchEBooks(error: "fakeError" ))
    }
}
