//
//  ListingInteractor.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

protocol ListingBusinessLogic {
    func getEBooks(request: ListingPage.GetEBooks.Request)
}

protocol ListingDataStore {
    var eBooks: [EBook]? { get set }
}

class ListingInteractor: ListingBusinessLogic, ListingDataStore {
    var presenter: ListingPresentationLogic?
    var worker = ListingWorker()
    var eBooks: [EBook]?

    func getEBooks(request: ListingPage.GetEBooks.Request) {
        guard let listingEBooks = eBooks else {
            presenter?.presentListing(
                response: ListingPage.GetEBooks.Response(
                    eBooks: nil,
                    error: ListingError.couldNotFetchEBooks(error: "Could not fetch books")))
            return
        }
        let response = ListingPage.GetEBooks.Response(eBooks: listingEBooks)
        presenter?.presentListing(response: response)
    }
}
