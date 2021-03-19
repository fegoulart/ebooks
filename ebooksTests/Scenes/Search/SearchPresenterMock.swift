//
//  SearchPresenterMock.swift
//  ebooksTests
//
//  Created by Fernando Luiz Goulart on 19/03/21.
//

@testable import ebooks

class SearchPresenterMock : SearchPresentationLogic {
    var trendings: [String]?
    var ebooks: [EBook]?

    func presentTrendings(response: SearchPage.GetTrendings.Response) {
        self.trendings = response.trendings
    }

    func presentSaveTrending(response: SearchPage.SaveTrending.Response) {
    }

    func presentSearch(response: SearchPage.FetchEBooks.Response) {
        self.ebooks = response.eBooks
    }
}
