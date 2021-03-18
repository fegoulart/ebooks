//
//  Data+Extensions.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 17/03/21.
//

import Alamofire

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
