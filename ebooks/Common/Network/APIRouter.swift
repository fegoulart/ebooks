//
//  APIRouter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

import Alamofire

enum Route {
    case getBooks(term: String)
}

class APIRouter: URLRequestConvertible {
    private var route: Route
    init (route: Route) {
        self.route = route
    }
    private var method: HTTPMethod {
        switch self.route {
        case .getBooks:
            return .get
        }
    }
    private var path: String {
        switch self.route {
        case Route.getBooks:
            return "search"
        }
    }
    private var parameters: Parameters? {
        switch self.route {
        case Route.getBooks(let term):
            return [APIConfig.ParameterKey.term.rawValue: term,
                    APIConfig.ParameterKey.media.rawValue: "ebook"]
        }
    }
    private var body: Parameters? {
        switch self.route {
        case Route.getBooks(_):
            return nil
        }
    }

    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        let formattedUrl = try APIConfig.baseURL.asURL()
        var urlRequest = URLRequest(url: formattedUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(
"\(APIConfig.HTTPHeaderFieldValue.json.rawValue), \(APIConfig.HTTPHeaderFieldValue.javascript.rawValue)",
            forHTTPHeaderField: APIConfig.HTTPHeaderFieldKey.acceptType.rawValue)
        urlRequest.setValue("\(APIConfig.HTTPHeaderFieldValue.json.rawValue)",
                            forHTTPHeaderField: APIConfig.HTTPHeaderFieldKey.contentType.rawValue)
        if let body = body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = data
            } catch (_) {
                print("APIRouter: Failed to parse body into request.")
            }
        }
        if let parameters = parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
