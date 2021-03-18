//
//  String+Extensions.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import Foundation

extension String {
    func fromHtml() -> String? {
        let data = self.data(using: .utf8)
        let description = try? NSAttributedString(data: data ?? Data(),
                                options: [.documentType: NSAttributedString.DocumentType.html,
                                .characterEncoding: String.Encoding.utf8.rawValue],
                                documentAttributes: nil)
        return description?.string
    }
}
