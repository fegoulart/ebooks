//
//  URL+Extensions.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 17/03/21.
//

import Alamofire

extension URLRequest {
    func log() {
        print("\(httpMethod ?? "") \(self)")
        print("BODY \n \(String(describing: httpBody?.toString()))")
        print("HEADERS \n \(String(describing: allHTTPHeaderFields))")
    }
}
