//
//  EBookDataManagers.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

import PromiseKit
import Alamofire

protocol EBookDataManager: AnyObject {
    func getEBooks(from term: String) -> Promise<EBooks>
}

final class EBookNetworkManager: EBookDataManager {
    func getEBooks(from term: String) -> Promise<EBooks> {
        return APIManager.callApi(APIRouter(route: Route.getBooks(term: term)), dataReturnType: EBooks.self)
    }
}
