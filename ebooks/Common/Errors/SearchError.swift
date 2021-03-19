//
//  SearchError.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

enum SearchError: Error {
    case couldNotFetchEBooks(error: String)
    case couldNotGetTrendings(error: String)
    case couldNotSaveTrending(error: String)
}
