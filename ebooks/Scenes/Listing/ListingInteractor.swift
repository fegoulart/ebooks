//
//  ListingInteractor.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

protocol ListingBusinessLogic {
    func fetchTerm(request: ListingPage.FetchEBooks.Request)
}

protocol ListingDataStore {
    var eBooks: [EBook]? { get }
}

class ListingInteractor: ListingBusinessLogic, ListingDataStore {
    var presenter: ListingPresentationLogic?
    var worker = ListingWorker()
    var eBooks: [EBook]?

    func fetchTerm(request: ListingPage.FetchEBooks.Request) {
        var response: ListingPage.FetchEBooks.Response!
        self.worker.eBookDataManager.getEBooks(from: request.term).done { receivedEBooks in
            var newEBooks: [EBook] = []
            for eBook in receivedEBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            self.eBooks = newEBooks
            response = ListingPage.FetchEBooks.Response(eBooks: self.eBooks, error: nil)

        }.catch { error in
            response = ListingPage.FetchEBooks.Response(
                eBooks: nil,
                error: ListingError.couldNotFetchEBooks(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentListing(response: response)
        }
    }
}
