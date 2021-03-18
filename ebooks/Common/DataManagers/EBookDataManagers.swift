//
//  EBookDataManagers.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

import PromiseKit
import Alamofire

protocol EBookNetworkInjected {
}

struct EBookNetworkInjector {
    static var networkManager: EBookDataManager = EBookNetworkManager()
}

extension EBookNetworkInjected {
    var eBookDataManager: EBookDataManager {
        return EBookNetworkInjector.networkManager
    }
}

protocol EBookDataManager: AnyObject {
    func getEBooks(from term: String) -> Promise<EBooks>
}

extension EBookDataManager {
    func getEBooks(from term: String, test: Bool  = false) -> Promise<EBooks> {
        return getEBooks(from: term)
    }
}

final class EBookNetworkManager: EBookDataManager {
    func getEBooks(from term: String) -> Promise<EBooks> {
        return APIManager.callApi(APIRouter(route: Route.getBooks(term: term)), dataReturnType: EBooks.self)
    }
}
