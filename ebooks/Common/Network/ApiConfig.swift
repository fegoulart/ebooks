//
//  ApiConfig.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

struct APIConfig {

    static let baseURL = "https://\(baseDomain)"
    static let baseDomain = "itunes.apple.com"
    enum ParameterKey: String {
        case country
        case limit
        case media
        case term
    }
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
        case javascript = "text/javascript"
    }
}
