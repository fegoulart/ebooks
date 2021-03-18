//
//  ListingError.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

enum ListingError: Error {
    case couldNotFetchEBooks(error: String)
}
